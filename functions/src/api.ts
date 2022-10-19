import axios from "axios";
import * as functions from "firebase-functions";
import * as admin from 'firebase-admin';
import * as jwt from "jsonwebtoken";
import Airtable from "airtable";

// Initialize firebase
admin.initializeApp();

export async function fetchJWT() {
    // Sign jwt token.
    const signedJWT = jwt.sign({}, process.env.MEETUP_PRIVATE_KEY || "", {
        algorithm: 'RS256',
        issuer: '21qd6ilvjvj2n6tlhl9u33388e',
        subject: '340369016',
        audience: 'api.meetup.com',
        keyid: 'pUbl8GdGO7OyhNDTxpFxwlRXncSNrAGk-ZmklY28Q7Y',
        expiresIn: 120
      });
      
    const headers = { 'Content-Type': 'application/x-www-form-urlencoded' };
    const params = new URLSearchParams();
    params.append("grant_type", "urn:ietf:params:oauth:grant-type:jwt-bearer");
    params.append("assertion", signedJWT);

    // Send signed jwt to get access token.
    const { data } = await axios.post("https://secure.meetup.com/oauth2/access", params, { headers })
    if (data) {
        return data;
    } else {
        throw Error("Could not fetch JWT");
    }
}

export async function refreshJWT(refreshToken: string) {
    const headers = { 'Content-Type': 'application/x-www-form-urlencoded' };
    const params = new URLSearchParams();
    params.append("client_id", "21qd6ilvjvj2n6tlhl9u33388e");
    params.append("client_secret", "hngvvpeef0lf3s83cenm2b8ftt");
    params.append("grant_type", "refresh_token");
    params.append("refresh_token", refreshToken);

    // Send signed jwt to get access token.
    const { data, ...result } = await axios.post("https://secure.meetup.com/oauth2/access", params, { headers });
    if (data) {
        console.log(data);
        return data;
    } else {
        throw Error(`Could not refresh access meetup.com ${result}`);
    }
}

export async function fetchMeetupEvents() {
    const { access_token } = await fetchJWT();
    const headers = { 'Content-Type': 'application/json', 'Authorization': `Bearer ${access_token}` };
    const params = { query: 'query { groupByUrlname(urlname: "renderatl") { id logo { baseUrl } upcomingEvents(input: {}) { edges { cursor node { id } } } pastEvents(input: {}) { edges { cursor node { id title eventUrl description shortDescription dateTime venue { id name address city state postalCode } images { id baseUrl } }} } } }' };
    const { data, ...result } = await axios.post("https://api.meetup.com/gql", params, { headers });
    if (data) {
        return data.data.groupByUrlname;
    } else {
        functions.logger.log(`Could not fetch events from meetup.com ${result}`);
    }
}

export async function addToMailchimp({ email, firstName, experience } : { email: string, firstName: string, experience?: string }) {
    try {
        const headers = { 'Content-Type': 'application/json', key: process.env.RENDER_SERVICE_KEY || "" };
        const params = {
            "listId": "e266f1a14b",
            "tags": ["mobileapp", "2023"],
            "email": email,
            "firstName": firstName,
            "experience": experience
        };
        const { data, ...result } = await axios.post("https://adoring-newton-de5d6b.netlify.app/api/subscribe", params, { headers });
        if (data) {
            return data;
        } else {
            functions.logger.log(`Could not add ${email} to mailchimp audience ${result}`);
        }
    } catch (e) {
        functions.logger.log(`Could not add to mailchimp audience ${e}`);
    }
}

export async function createDiscontCode({ email } : { email: string }) {
    const db = admin.firestore().collection('discountCodes').doc(email);
    try {
        const headers = { 'Content-Type': 'application/json', key: process.env.RENDER_SERVICE_KEY || "" };
        const validateStatus = (status: number) => status >= 200 && status < 500;
        const params = {
            "eventSlug": "2023",
            "discountCode": email,
            "discountType": "MoneyOffDiscountCode",
            "discountAmount": "50.0",
            "discountQuantity": "1",
            "ticketId": [1378784, 1378785, 1378775]
        };
        const result = await axios.post("https://adoring-newton-de5d6b.netlify.app/api/discount", params, { headers, validateStatus });
        if (result?.data && result.data?.message) {
            delete result.data.message.statusCode;
            await db.create(result.data.message);
            functions.logger.log(`Added discount code to ${email} ${result.data.message.code}`);
            return result.data;
        } else {
            functions.logger.log(`Could not create discount for ${email}, ${result.data}`);
        }
    } catch (e) {
        functions.logger.log(`Could not create discount ${e}`);
    }
}

export async function fetchJobs() {
    // Initialize airtable
    Airtable.configure({
        endpointUrl: 'https://api.airtable.com',
        apiKey: process.env.RENDER_AIRTABLE_KEY,
    });
    const base = Airtable.base('app0Zd3TKjPbrlPZA');
    const jobs: any[] = [];

    return new Promise((resolve, reject) => {
        base('2023').select({
            view: "Grid view"
        }).eachPage(function page(records, fetchNextPage: () => void) {
            // This function (`page`) will get called for each page of records.
            records.forEach(function(record) {
                jobs.push(record);
            });
        
            // To fetch the next page of records, call `fetchNextPage`.
            // If there are more records, `page` will get called again.
            // If there are no more records, `done` will get called.
            fetchNextPage();
        }, function done(err: any) {
            if (err) { 
                console.error(err); 
                reject(err);
                return; 
            }
            resolve(jobs);
        });
    });
}

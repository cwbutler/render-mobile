import * as functions from "firebase-functions";
import * as jwt from "jsonwebtoken";
import axios from "axios";

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript

/**
 * Function to grab jwt token access for meetup.com
 */
export const getMeetupAccess = functions.https.onRequest((_, res) => {
  try {
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
    axios.post("https://secure.meetup.com/oauth2/access", params, { headers })
      .then(result => {
        if (result?.data) {
          res.send({ data: result.data });
        } else {
          res.status(500).send(`Could not access meetup.com ${result}`);
        }
      });
  } catch (e) {
    res.status(500).send(`Could not access meetup.com ${e}`);
  }
});

/**
 * Function to refresh jwt token access for meetup.com
 */
export const refreshMeetupAccess = functions.https.onRequest((req, res) => {
  try {
    const headers = { 'Content-Type': 'application/x-www-form-urlencoded' };
    const params = new URLSearchParams();
    params.append("client_id", "21qd6ilvjvj2n6tlhl9u33388e");
    params.append("client_secret", "hngvvpeef0lf3s83cenm2b8ftt");
    params.append("grant_type", "refresh_token");
    params.append("refresh_token", req.body["refresh_token"]);

    // Send signed jwt to get access token.
    axios.post("https://secure.meetup.com/oauth2/access", params, { headers })
      .then(result => {
        if (result?.data) {
          res.send({ data: result.data });
        } else {
          res.status(500).send(`Could not refresh access meetup.com ${result}`);
        }
      });
  } catch (e) {
    res.status(500).send(`Could not refresh access meetup.com ${e}`);
  }
});

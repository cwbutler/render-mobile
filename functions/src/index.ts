import * as functions from "firebase-functions";
import * as admin from 'firebase-admin';
import * as api from "./api";

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript

/**
 * Function to grab jwt token access for meetup.com
 */
export const getMeetupAccess = functions.https.onRequest(async (_, res) => {
  try {
    const jwt = await api.fetchJWT();
    res.send({ data: jwt });
  } catch (e) {
    res.status(500).send(`Could not access meetup.com ${e}`);
  }
});

/**
 * Function to refresh jwt token access for meetup.com
 */
export const refreshMeetupAccess = functions.https.onRequest(async (req, res) => {
  try {
    const data = await api.refreshJWT(req.body["refresh_token"]);
    res.send({ data });
  } catch (e) {
    res.status(500).send(`Could not refresh access meetup.com ${e}`);
  }
});

/**
 * Function to fetch meetup.com events
 */
export const fetchMeetupEvents = functions.https.onRequest(async (_, res) => {
  try {
    const data = await api.fetchMeetupEvents();
    res.send({ data: data.pastEvents.edges });
  } catch (e) {
    res.status(500).send(`Could not fetch events from meetup.com ${e}`);
  }
});

/**
 * Function to fetch render jobs from airtable
 */
 export const fetchJobs = functions.https.onRequest(async (_, res) => {
  try {
    const data = await api.fetchJobs();
    res.send({ data });
  } catch (e) {
    res.status(500).send(`Could not fetch jobs ${e}`);
  }
});

/**
 * Function to rsvp user to event.
 */
 export const rsvpEvent = functions.https.onCall(async (data) => {
  try {
    await api.rsvpEvent(data);
    return true;
  } catch (e) {
    return false;
  }
});

/**
 * Function to check user rsvp to event.
 */
 export const checkRSVP = functions.https.onCall(async (data) => {
  try {
    const result = await api.checkRSVP(data);
    console.log("check result", result);
    return result;
  } catch (e) {
    console.log("error checking rsvp", e);
    return false;
  }
});

export const createUser = functions.firestore
    .document('users/{userId}')
    .onCreate(async (snap: { data: () => any; }) => {
      try {
        // Get an object representing the document
        const newUser = snap.data();
        await api.addToMailchimp({ email: newUser.email, firstName: newUser.first_name });
        const result = await api.createDiscontCode({ email: newUser.email });
        const message = {
          notification: {
            title: "Welcome to Render",
            body: `Here is your discont code for Render Conference tickets! ${result.message.code}
            Here is link to your code: ${result.message.link}`
          },
          token: newUser.fcmToken
        };
        await admin.messaging().send(message);
        await admin.firestore().doc(newUser.id).collection("messages").add(message);
      } catch (e) {
        console.log(e);
      }
    });

export const deleteUser = functions.firestore
    .document('users/{userId}')
    .onDelete(async (snap: { data: () => any; }) => {
      try {
        // Get an object representing the document
        const newUser = snap.data();
        await admin.firestore().collection('discountCodes').doc(newUser.email).delete();
        await admin.firestore().doc(newUser.id).delete();
      } catch (e) {
        console.log(e);
      }
    });

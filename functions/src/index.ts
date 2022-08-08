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

export const createUser = functions.firestore
    .document('users/{userId}')
    .onCreate(async (snap: { data: () => any; }) => {
      try {
        // Get an object representing the document
        const newUser = snap.data();
        await api.addToMailchimp({ email: newUser.email, firstName: newUser.first_name });
        const { message: { code, link } } = await api.createDiscontCode({ email: newUser.email });
        const message = {
          notification: {
            title: "Welcome to Render",
            body: `Here is your discont code for Render Conference tickets! ${code}
            Here is link to your code: ${link}`
          },
          token: newUser.fcmToken
        };
        admin.messaging().send(message);
        admin.firestore().collection('notifications').doc(newUser.id).collection(newUser.email).add({ id: newUser.id, message });
      } catch (e) {
        console.log(e);
      }
    });

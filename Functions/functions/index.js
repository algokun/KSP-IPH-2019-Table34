const functions = require("firebase-functions");
const admin = require("firebase-admin");
const serviceAccount = require("./serviceAccount");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

exports.sendMessageNotification = functions.firestore
  .document("messages/{hashId}/chats/{docId}")
  .onCreate((snapshot, context) => {
    const content = snapshot.data().content;
    const idFrom = snapshot.data().idFrom;
    const idTo = snapshot.data().idTo;

    var userRef = admin
      .firestore()
      .collection("users")
      .doc(idFrom)
      .get()
      .then(userDoc => {
        const userName = userDoc.data().name;

        return admin
          .firestore()
          .collection("tokens")
          .doc(idTo)
          .get()
          .then(tokenDoc => {
            const token = tokenDoc.data().fcmToken;

            var paylod = {
              notification: {
                title: "You have got a new Message from " + userName,
                body: content,
                sound: "default"
              },
              data: {
                sendername: idFrom,
                message: "Message"
              }
            };

            return admin
              .messaging()
              .sendToDevice(token, paylod)
              .then(value => {
                console.log("pushed");
                return "Pushed";
              })
              .catch(err => {
                console.log(err);
                console.log("Failed");
              });
          });
      });
  });

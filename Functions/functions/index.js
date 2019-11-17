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
    const isSecure = snapshot.data().isSecure;

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

            return isSecure
              ? null
              : admin
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

exports.sendSecureMsgNotification = functions.firestore
  .document("secure_chat/{hashId}/chats/{docId}")
  .onCreate((snapshot, context) => {
    const content = snapshot.data().content;
    const idFrom = snapshot.data().idFrom;
    const idTo = snapshot.data().idTo;

    setTimeout(function() {
      snapshot.ref.delete();
    }, 60000);

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
                title: "You have got a new Secure Message from " + userName,
                body: "Read it before 60s.",
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

// exports.deleteMessages = functions
//   .runWith({
//     memory: "2GB"
//   })
//   .pubsub.schedule("* * * * *")
//   .onRun(async context => {
//     const timeNow = new Date(Date.now().toString());
//     const messagesRef = await admin
//       .firestore()
//       .collectionGroup("chats")
//       .get();

//     messagesRef.forEach(each => {
//       const time = new Date(each.data().timeStamp);
//       const diff = timeNow.getTime() - time.getTime();
//       var seconds = (endDate.getTime() - startDate.getTime()) / 1000;

//       if (seconds <= 36000) {
//         each.ref.update({
//           isExpired: true
//         });
//       }
//     });
//   });

  exports.deleteOldMessages = functions
  .https.onRequest(async (req , res) => {
    const timeNow = new Date();
    const messagesRef = await admin
      .firestore()
      .collectionGroup("chats")
      .get();

    messagesRef.forEach(each => {
      const time = new Date(each.data().timeStamp);
      const diff = timeNow.getTime() - time.getTime();
      var seconds = diff / 1000;
      console.log("WOriking")
      console.log(seconds);
      
      if (seconds > 36000) {
        each.ref.update({
          isExpired: true
        });
      }
    });
    return res.status(200).end();
  });

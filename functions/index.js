const functions = require('firebase-functions');
// const admin = require('firebase-admin');
// admin.initializeApp();
var admin = require("firebase-admin");

var serviceAccount = require("path/to/serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://healthcare-app-6417-default-rtdb.firebaseio.com"
});

exports.approveDoctor = functions.firestore
  .document('Doctor/{doctorId}')
  .onCreate(async (snapshot, context) => {
    const doctorRef = snapshot.ref;

    // Perform your approval logic here, for example, by manually reviewing the document or using an external API.
    // If the doctor is approved, update the 'approved' field to true.
    try {
      await doctorRef.update({ approved: true });
      console.log('Doctor approved successfully');
    } catch (error) {
      console.error('Error approving doctor:', error);
    }
  });

  module.exports = {
    approveDoctor: exports.approveDoctor,
  };
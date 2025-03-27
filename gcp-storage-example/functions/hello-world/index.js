/**
 * Background Cloud Function to be triggered by Cloud Storage.
 * This function is exported by index.js, and executed when
 * a file is uploaded to the Storage bucket you created.
 *
 * @param {object} file The Cloud Storage file metadata.
 * @param {object} context The event metadata.
 */
exports.helloWorld = (file, context) => {
  console.log(`Processing file: ${file.name}`);
  console.log(`File created: ${file.timeCreated}`);
  console.log(`File size: ${file.size} bytes`);
  console.log(`File content type: ${file.contentType}`);
  console.log(`File metageneration: ${file.metageneration}`);
  console.log(`File storage class: ${file.storageClass}`);
  console.log(`Bucket: ${file.bucket}`);
  
  // Do something with the file
  
  console.log('File processing complete!');
};

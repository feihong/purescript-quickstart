/**
 * Print out a compressed text file's contents, line by line.
 */
const { pipeline } = require("stream");
const fs = require("fs");
const readline = require("readline");
const zlib = require("zlib");

const filename = "output.txt.gz";
let readStream = fs.createReadStream(filename);
let gunzip = zlib.createGunzip();
pipeline(readStream, gunzip, err => {
  if (err) {
    console.log("pipeline failed");
  }
});
// This object conforms to the async iterable protocol
let rl = readline.createInterface({ input: gunzip });

// (async function() {
//   for await (const line of rl) {
//     console.log(line);
//   }
// })();

rl.on("line", line => console.log(line));

// Doesn't work
rl.on("data", line => console.log(line));

rl.on("close", line => console.log("No more lines"));

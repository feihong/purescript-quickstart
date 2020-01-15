const openDb = require("better-sqlite3");

exports.openDb = function(path) {
  return openDb(path);
};

exports.closeDb = function(db) {
  db.close();
};

exports.execImpl = function(db, statements) {
  db.exec(statements);
};

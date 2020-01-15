const openDb = require("better-sqlite3");

exports.openDb = function(path) {
  // You need a nested function here because of Effect
  return function() {
    return openDb(path);
  };
};

exports.closeDb = function(db) {
  return function() {
    db.close();
  };
};

exports.execImpl = function(db, statements) {
  return function() {
    db.exec(statements);
  };
};

exports.prepareImpl = function(db, statement) {
  return function() {
    return db.prepare(statement);
  };
};

exports.runImpl = function(statement, params) {
  return function() {
    statement.run.apply(statement, params);
  };
};

exports.allImpl = function(statement, params) {
  return function() {
    return statement.all.apply(statement, params);
  };
};

const openDb = require("better-sqlite3");

const db = openDb("./output.sqlite3");

db.exec(`
CREATE TABLE IF NOT EXISTS entry (
  id integer primary key unique,
  traditional text,
  simplified text,
  pinyin text,
  gloss text
)`);

const stmt = db.prepare(`
INSERT OR REPLACE INTO entry VALUES (
  $id, $traditional, $simplified, $pinyin, $gloss
)`);

// 優美 优美 [you1 mei3] /graceful/fine/elegant/
stmt.run({
  id: 1,
  traditional: "優美",
  simplified: "优美",
  pinyin: "you1 mei3",
  gloss: "graceful/fine/elegant"
});

const stmt2 = db.prepare("SELECT * FROM entry");

for (const row of stmt2.all()) {
  console.log(row);
}

db.close();

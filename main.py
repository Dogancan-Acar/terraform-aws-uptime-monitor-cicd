from fastapi import FastAPI
from pydantic import BaseModel
import requests
import sqlite3

app = FastAPI()

conn = sqlite3.connect('database.db', check_same_thread=False)
cursor = conn.cursor()
cursor.execute('''
    CREATE TABLE IF NOT EXISTS websites (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        url TEXT NOT NULL,
        status TEXT
    )
''')
conn.commit()

class WebsiteRequest(BaseModel):
    url: str

@app.post("/add-website/")
def add_website(data: WebsiteRequest):
    cursor.execute("INSERT INTO websites (url, status) VALUES (?, ?)", (data.url, "Bilinmiyor"))
    conn.commit()
    return {"mesaj": f"{data.url} sisteme eklendi!"}

@app.get("/check-status/")
def check_status():
    cursor.execute("SELECT id, url FROM websites")
    siteler = cursor.fetchall()
    sonuclar = []
    for site in siteler:
        site_id, url = site[0], site[1]
        try:
            cevap = requests.get(url, timeout=5)
            durum = f"Ayakta (Kod: {cevap.status_code})" if cevap.status_code == 200 else "Hata!"
        except:
            durum = "Ulaşılamıyor / Çöktü"    
        cursor.execute("UPDATE websites SET status = ? WHERE id = ?", (durum, site_id))
        sonuclar.append({"id": site_id, "url": url, "sonuc": durum})
    conn.commit()
    return {"Guncel Durumlar": sonuclar}

@app.delete("/delete-website/{site_id}")
def delete_website(site_id: int):
    cursor.execute("DELETE FROM websites WHERE id = ?", (site_id,))
    conn.commit()
    return {"mesaj": f"ID'si {site_id} olan site başarıyla silindi!"}
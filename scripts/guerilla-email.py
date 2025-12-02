#!/usr/bin/env python3

import sys
import time
import requests

API_URL = "https://api.guerrillamail.com/ajax.php"
IGNORED_SENDER = "no-reply@guerrillamail.com"


def get_email_address():
    params = {
        "f": "get_email_address",
        "lang": "en",
        "ip": "127.0.0.1",
        "agent": "python-script",
    }
    r = requests.get(API_URL, params=params, timeout=10)
    r.raise_for_status()
    data = r.json()
    return data["email_addr"], data["sid_token"]


def get_email_list(sid):
    params = {
        "f": "get_email_list",
        "offset": 0,
        "sid_token": sid,
        "ip": "127.0.0.1",
        "agent": "python-script",
    }
    r = requests.get(API_URL, params=params, timeout=10)
    r.raise_for_status()
    return r.json().get("list", [])


def fetch_email(sid, mail_id):
    params = {
        "f": "fetch_email",
        "email_id": mail_id,
        "sid_token": sid,
        "ip": "127.0.0.1",
        "agent": "python-script",
    }
    r = requests.get(API_URL, params=params, timeout=10)
    r.raise_for_status()
    return r.json()


def is_intro_message(msg):
    sender = msg.get("mail_from", "").lower()
    return IGNORED_SENDER in sender


def main():
    if len(sys.argv) > 2:
        print("Usage: python script.py [num_messages]")
        return

    if len(sys.argv) == 2:
        try:
            target = int(sys.argv[1])
        except ValueError:
            print("Argument must be an integer (0 = infinite).")
            return
    else:
        target = 1

    email, sid = get_email_address()
    print("Temporary email:", email)

    printed = 0
    seen = set()

    print("Waiting for messages...")

    while True:
        msgs = get_email_list(sid)

        for m in msgs:
            mail_id = m["mail_id"]

            if mail_id in seen:
                continue
            seen.add(mail_id)

            if is_intro_message(m):
                continue

            full = fetch_email(sid, mail_id)
            print("\n- New Email Received -")
            print("\tFrom:   ", full.get("mail_from"))
            print("\tSubject:", full.get("mail_subject"))
            print("Body:\n", full.get("mail_body"))
            print("-\n")

            printed += 1

            if target != 0 and printed >= target:
                return

        time.sleep(5)


if __name__ == "__main__":
    main()

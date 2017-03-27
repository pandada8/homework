import getpass
import sys
import os
import logging

data = None
subs = []

def load_data():
    try:
        with open(os.path.expanduser("~/.books_db.json")) as fp:
            return json.load(fp)
    except Exception as e:
        logging.exception("Fail to parse db")

def save_data(data):
    try:
        with open(os.path.expanduser("~/.books_db.json", "w")) as fp:
            json.dump(fp, data)
    except Exception as e:
        logging.exception("Fail to dump db")


def login():
    retry = 0
    while retry <= 3:
        retry += 1
        password = input("Password:")
        if password != data['password']:
            print("Wrong Password")
            continue
    print("Login Failed, wrong password")
    sys.exit(1)

def dispatch_action(question, prompt, actions):
    while True:
        print(question)
        for n, i in enumerate(actions):
            print("{}: {}".format(n + 1, i.__doc__))
        n = None
        while True:
            try:
                n = input(prompt)
                n = int(n) - 1
                if 0 <= n < len(actions):
                    break
            except Exception:
                continue
            except KeyboardInterrupt:
                exit()
        actions[n]()



def book_management():
    done = False
    data['books'] = data.get("books", [])
    def add_book():
        book = {}
        book['name'] = input("Name: ")
        book['id'] = input("ID: ")
        book['author'] = input("Author: ")
        book['date'] = input("Date: ")
        book['publisher'] = input("Publisher: ")
        book['price'] = input("Price: ")
        book['type'] = input("Type: ")
        data['books'].append(book)

    def view_book():
        for i in data['books']:
            print("{id} {name} {author} {date} {publisher} {price} {type}".format(**i))

    def query_book():
        for i in 

    while not done:
        


def exit():
    """退出系统"""
    save_data(data)
    sys.exit(0)

subs.append(exit)

def main():
    load_data()
    dispatch_action(subs)

if __name__ == "__main__":
    main()

import os
import pymysql
from flask import Flask, render_template, request, redirect, url_for, abort

app = Flask(__name__)


def get_db():
    return pymysql.connect(
        host=os.environ.get("DB_HOST", "db"),
        user=os.environ["DB_USER"],
        password=os.environ["DB_PASSWORD"],
        database=os.environ["DB_NAME"],
        charset="utf8mb4",
        cursorclass=pymysql.cursors.DictCursor,
    )


@app.route("/")
def index():
    category_id = request.args.get("category", type=int)
    conn = get_db()
    try:
        with conn.cursor() as cur:
            cur.execute("SELECT id, name FROM categories ORDER BY name")
            categories = cur.fetchall()
            sql = """SELECT r.id, r.title, c.name AS category
                     FROM recipes r JOIN categories c ON r.category_id = c.id"""
            if category_id:
                cur.execute(sql + " WHERE r.category_id = %s ORDER BY r.id DESC",
                            (category_id,))
            else:
                cur.execute(sql + " ORDER BY r.id DESC")
            recipes = cur.fetchall()
    finally:
        conn.close()
    return render_template("index.html", recipes=recipes,
                           categories=categories, selected=category_id)


@app.route("/recipe/<int:recipe_id>")
def recipe(recipe_id):
    conn = get_db()
    try:
        with conn.cursor() as cur:
            cur.execute("""SELECT r.*, c.name AS category
                           FROM recipes r JOIN categories c ON r.category_id = c.id
                           WHERE r.id = %s""", (recipe_id,))
            item = cur.fetchone()
    finally:
        conn.close()
    if not item:
        abort(404)
    return render_template("recipe.html", r=item)


@app.route("/add", methods=["GET", "POST"])
def add():
    conn = get_db()
    try:
        with conn.cursor() as cur:
            if request.method == "POST":
                cur.execute(
                    """INSERT INTO recipes (title, category_id, ingredients, instructions)
                       VALUES (%s, %s, %s, %s)""",
                    (request.form["title"], request.form["category_id"],
                     request.form["ingredients"], request.form["instructions"]),
                )
                conn.commit()
                return redirect(url_for("index"))
            cur.execute("SELECT id, name FROM categories ORDER BY name")
            categories = cur.fetchall()
    finally:
        conn.close()
    return render_template("add.html", categories=categories)


@app.route("/delete/<int:recipe_id>", methods=["POST"])
def delete(recipe_id):
    conn = get_db()
    try:
        with conn.cursor() as cur:
            cur.execute("DELETE FROM recipes WHERE id = %s", (recipe_id,))
            conn.commit()
    finally:
        conn.close()
    return redirect(url_for("index"))


@app.route("/health")
def health():
    return {"status": "ok"}
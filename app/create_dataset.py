import pandas as pd
from sqlalchemy import create_engine


def get_userid(login, db1_url):
    try:
        engine_db1 = create_engine(db1_url)
        query = f"SELECT * FROM users WHERE login = '{login}'"
        data = pd.read_sql_query(query, engine_db1)
        return data.iloc[0]['id']
    except Exception as e:
        print(f"Error: {e}")
        return None
    finally:
        engine_db1.dispose()


def get_user_comments(login, db1_url):
    try:
        engine_db1 = create_engine(db1_url)
        query_posts = f"""
        SELECT DISTINCT u.login as login, p.header as header, p.id as post_id, a.login as author
        FROM users u
        JOIN comments c ON c.user_id = u.id
        JOIN post p ON c.post_id = p.id
        JOIN users a ON p.author_id = a.id
        WHERE u.login = '{login}'
        """
        posts_data = pd.read_sql_query(query_posts, engine_db1)
        query_comments = f"""
        SELECT p.id as post_id, count(c.id) as comments_count
        FROM post p
        JOIN comments c ON p.id = c.post_id
        WHERE p.id in ({', '.join(posts_data['post_id'].astype(str))})
        GROUP BY p.id
        """
        comments_data = pd.read_sql_query(query_comments, engine_db1)
        return pd.merge(posts_data, comments_data, on='post_id', how='left')[['login', 'header', 'author', 'comments_count']]
    except Exception as e:
        print(f"Error: {e}")
        return pd.DataFrame()
    finally:
        engine_db1.dispose()


def get_user_logs(login, db2_url, db1_url):
    try:
        engine_db2 = create_engine(db2_url)
        user_id = get_userid(login, db1_url)
        query = f"""
        SELECT date(datetime) as date, count(et.name = 'login') as login_count, count(et.name = 'logout'), count(st.name = 'blog' or st.name = 'post') as posts_count
        FROM logs l
        JOIN event_type et ON l.event_type_id = et.id
        JOIN space_type st ON l.space_type_id = st.id
        WHERE l.user_id = '{user_id}'
        GROUP BY date
        """
        data = pd.read_sql_query(query, engine_db2)
        data['date'] = pd.to_datetime(data['date']).dt.strftime('%Y-%m-%d')
        return data
    except Exception as e:
        print(f"Error: {e}")
        return pd.DataFrame()
    finally:
        engine_db2.dispose()

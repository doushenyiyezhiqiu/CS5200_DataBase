import pymysql

try:
    userN = input('Please enter your user name:')
    passW = input('Please enter your password:')

    cnx = pymysql.connect(host='localhost', user=userN,
                          password=passW,
                          db='lotrfinal_lil', charset='utf8mb4',
                          cursorclass=pymysql.cursors.DictCursor)

except pymysql.err.OperationalError as e:
    print('Error: %d: %s' % (e.args[0], e.args[1]))

try:
    while True:
        stmt_select = 'select distinct character_name from lotr_character'
        cur = cnx.cursor()

        cur.execute(stmt_select)
        rows = cur.fetchall()
        print('All characters existed are listed below:')
        temp = [];
        for row in rows:
            print(row['character_name'])
            temp.append(row['character_name'].lower())
            pass

        print('')
        char_name = input("Please enter the name of character who you want to track:")
        char_name = char_name.lower()
        if char_name in temp:
            c2 = cnx.cursor()
            stmt_callproc = 'call track_character(\'' + char_name + '\')'
            c2.execute(stmt_callproc)
            print('The result is:')
            for row in c2.fetchall():
                print(row)
                pass
            break
        else:
            print('The name of character you enter is not in the list of characters.')
            print('Please enter a new name in the list of characters')
            continue

except pymysql.Error as e:
    print('Error: %d: %s' % (e.args[0], e.args[1]))

finally:
    cnx.close()


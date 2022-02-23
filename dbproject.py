##DB_PROJECT PYTHON PROGRAM

#########################################################
####### Kopioitu pätkä viikon 6, Python tehtävästä ######
import sqlite3
db = sqlite3.connect('DB_project.db')
cur = db.cursor()
def initializeDB():
    try:
        f = open("sql_commands.sql", "r")
        commandstring = ""
        for line in f.readlines():
            commandstring+=line
        cur.executescript(commandstring)
    except sqlite3.OperationalError:
        print("Database exists, skip initialization")
    except:
        print("No SQL file to be used for initialization") 

#####################################################


def main():
    initializeDB()
    userInput = -1
    while(userInput != "0"):
        print("\nMenu options:")
        print("1: Print products")
        print("2: Print orders (user: ordered)")
        print("3: Search payments duedate for one user")
        print("4: Change order for one user")
        print("5: Insert new product")
        print("0: Quit")
        userInput = input("What do you want to do? ")
        print('\n')
        if userInput == "1":
            printProducts()
        if userInput == "2":
            printOrders()
        if userInput == "3":
            searchDuedate()
        if userInput == "4":
            changeOrder()
        if userInput == "5":
            insertProduct()
        if userInput == "0":
            print("Ending software...")
    db.close()        
    return



def printProducts():
    print("Printing products")
    """
    Printing all products from both warehouse or just from one.
    """

    choice = input("Do you want to print products from both(B) or one warehouse(O)? (B/O) ")
    
    if choice == 'B':
        print("(id, name, price)")
        for row in cur.execute('SELECT ProductID, Name, Price FROM Products'):
            print(row)
    elif choice == 'O':
        warehouse = int(input("From wich warehouse? "))
        print("(id, name, price)")
        if warehouse == 1:
            for row in cur.execute('SELECT Products.ProductID, Products.Name, Products.Price FROM Products INNER JOIN Warehouse ON Products.WarehouseID = Warehouse.WarehouseID WHERE Warehouse.WarehouseID = 1'):
                print(row)
        elif warehouse == 2:
            for row in cur.execute('SELECT Products.ProductID, Products.Name, Products.Price FROM Products INNER JOIN Warehouse ON Products.WarehouseID = Warehouse.WarehouseID WHERE Warehouse.WarehouseID = 2'):
                print(row)
        else:
            print("Warehouse not recognized.")
    else:
        print("Choose 'B' or 'O'.")
    return


def printOrders():
    print("Printing orders")
    """
    Printing all orders by the order number
    and in format ('who ordered', 'what ordered').
    """

    for row in cur.execute('SELECT Username, Name FROM Orders INNER JOIN User ON Orders.OrderID = User.OrderID INNER JOIN Products ON Orders.ProductID = Products.ProductID'):
        print(row)
    return


def searchDuedate():
    order = input("What the order's ID? ")
    """ 
    Insert the correct Python and SQL commands 
    to print all ranking information
    """

    cur.execute("SELECT Duedate FROM Payment WHERE OrderID = (?)", (order,))
    date = cur.fetchone()

    print("The duedate for order " + order + " is:")
    print(date)

    return


def changeOrder():
    print("Changing order")
    """ 
    Changing product to another for wanted order.
    """
    order = input("What is the id of your order? ")
    print("Order now:")
    cur.execute('SELECT Username, Name FROM Orders INNER JOIN User ON Orders.OrderID = User.OrderID INNER JOIN Products ON Orders.ProductID = Products.ProductID WHERE Orders.OrderID = (?)', (order,))
    info = cur.fetchone()
    print(info)
    print("You can choose one of the following products:")
    printProducts()
    product = input ("What is the id of the new product you want to buy? ")

    cur.execute("UPDATE Orders SET ProductID = (?) WHERE OrderID = (?)", (product, order,))
    print("Order updated.")
    printOrders()

    return


def insertProduct():
    #counts amount of the products
    x = 1
    for row in cur.execute('SELECT * FROM Products'):
        x += 1
        
    name = input("What product you want to insert? (name of the product) ")
    warehouse = input("Which warehouse? ")
    price = input("What is the price of the product? ")
    
    cur.execute("INSERT INTO Products VALUES (?, ?, ?, ?);", (x, int(warehouse), int(price), name,))

    printProducts()   

    return




main()

routes = []

#  starting point  cities list , starting path , distance 
def find_paths(node,cities, path, distance):
    # Add way point
    path.append(node)

    # Calculate path length from current to last node
    if len(path) > 1:
        distance += cities[path[-2]][node]

    # If path contains all cities and is not a dead end,
    # add path from last to first city and return.
    if (len(cities) == len(path)) and (path[0] in cities[path[-1]]):
        global routes
        path.append(path[0])
        distance += cities[path[-2]][path[0]]
        print (path, distance)
        routes.append([distance, path])
        return

    # Fork paths for all possible cities not yet used
    for city in cities:
        if (city not in path) and (node in cities[city]):
            find_paths(city, dict(cities), list(path), distance)

# only run this if we run tsp.py as the main file
if __name__ == '__main__':


    # List of cities
    cities = {
        '1': {'1': 0, '2': 10, '3': 15, '4': 20},
        '2': {'1': 5, '2': 0, '3': 9, '4': 10},
        '3': {'1': 6, '2': 13, '3': 0,'4': 12},
        '4': {'1': 8, '2': 8, '3': 9, '4': 0},
    }

    print ("Start: ")
    find_paths('1', cities, [], 0)
    print ("\n")
    routes.sort()
    if len(routes) != 0:
        print ("Shortest route: %s" % routes[0])
    else:
        print ("FAIL!")
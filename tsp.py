routes = []
def find_paths(node,cities, path, distance):
    # Add way point
    path.append(node)

    # Calculate path length from current to last added node
    if len(path) > 1:
        distance += cities[path[-2]][node]

    # If path contains all cities and is not a dead end,
    if (len(cities) == len(path)) and (path[0] in cities[path[-1]]):
        # to allow acces [`routes`] which is a global variable
        global routes
        # add path from last to first city.
        path.append(path[0])
        # add distance from last to first city
        distance += cities[path[-2]][path[0]]
        print (path, distance)
        # add it this path to routes list
        routes.append([distance, path])
        # return and continue the recursive calls
        return

    # for every not used city in cities
    for city in cities:
        # if city is not in path and not in any city dictionary
        if (city not in path) and (node in cities[city]):
            # call the function recursively with cities dictionary and new path
            find_paths(city, dict(cities), list(path), distance)

# only run this if we run tsp.py as the main file
if __name__ == '__main__':

    # dictionary of dicionary of cities
    cities = {
        '1': {'1': 0, '2': 10, '3': 15, '4': 20},
        '2': {'1': 5, '2': 0, '3': 9, '4': 10},
        '3': {'1': 6, '2': 13, '3': 0,'4': 12},
        '4': {'1': 8, '2': 8, '3': 9, '4': 0},
    }
    print ("Start: ")
    # find path for node 1 with cities list , empty list , 0 for initial starting path and distance
    find_paths('1', cities, [], 0)
    print ("\n")
    # Sort the routes in descending order
    routes.sort()
    # if routes are not empty print first list in routes 
    if len(routes) != 0:
        print ("Shortest route: %s" % routes[0])
    else:
        print ("FAIL!")
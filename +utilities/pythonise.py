import matlab
import PyQrackling
import json
import numpy
import datetime
from typing import Any
def pythonise(input)-> Any:
    """
    Convert a MATLAB object to a dict with corresponding structure consisting of numpy arrays
    and python native types.
    """ 
    # 3 Steps:
    ## 1. serial object in MATLAB
    ## 2. deserialise object in Python
    ## 3. convert lists to numpy arrays
    
    # 1. Serialise
    PyQ = PyQrackling.initialize()
    serial_string = PyQ.utilities.jsonEncodeObject(input)
    
    # 2. Deserialise
    python_object = json.loads(serial_string)
    
    # 3. convert lists to numpy arrays
    return jsoncleanup(python_object)


  
def jsoncleanup(input)-> Any:
    """takes the dict output of a json read-in and goes through the full structure,
    converting lists to numpy arrays where appropriate"""
    # Different objects are dealt with differently in a match-case structure
    
    match input:
        case list():
            # if list contains only numbers, datetimes or logicals, convert to numpy array
            is_numeric_list = all(isinstance(item, (float,int)) for item in input)
               
            if is_numeric_list:
                return numpy.array(input)
            
            # if list contains only bools, convert to numpy array of bools
            is_bool_list = all(isinstance(item, bool) for item in input)
               
            if is_bool_list:
                return numpy.array(input, dtype=bool)
            
            # if list contains strings, this could be a datetime array
            is_str_list = all(isinstance(item, str) for item in input)
            try:
                # try to convert one to datetime using ISO format 
                dt = datetime.datetime.fromisoformat(input[0])
                # if this works, convert the whole list
                dt_list = list(map(datetime.datetime.fromisoformat,input))
                dt_array = numpy.array(dt_list)
                return dt_array
            except:
                try:
                    # if this doesn't work, try a different format
                    dt = datetime.datetime.strptime(input[0],"%d-%b-%Y %H:%M:%S")
                    # if this works, convert the whole list
                    for number,dt_str in enumerate(input):
                        input[number] = datetime.datetime.strptime(dt_str,"%d-%b-%Y %H:%M:%S")
                    dt_array = numpy.array(input)
                    return dt_array
                except:
                    # if this doesn't work, return the original
                    return input

            
            # if this list contains lists, this should be an array
            is_list_of_lists = all(isinstance(item, list) for item in input)
            if is_list_of_lists:
                return numpy.array(input)
            
            
        case dict():
            # if is a dict, go through entries recursively to test if it contains lists
            for key, value in input.items():
                new_value = jsoncleanup(value)
                input[key] = new_value
            
            # once each entry has been tested, return
            return input
        
        case _:
            return input


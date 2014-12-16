import numpy
import rand

def makeflake(radius, prefill, minimum, maximum):
    min_num = minimum*radius*(radius+1)/2
    max_num = maximum*radius*(radius+1)/2
    
    mask = numpy.tril(ones(radius))

if __name__ == '__main__':
    makeflake(radius = 4, prefill = 2, minimum = .1, maximum = .8)

#
# template.py 
#
# A record of best-practices informed first by PEP 0008.
# 
# Judith E. Bush
# Time-stamp: "2015-05-29 12:24:54 bushj"
#
# References:
# PEP 0008 Style Guide for Python Code
#     https://www.python.org/dev/peps/pep-0008/
# PEP 0257 Docstring Conventions
#     https://www.python.org/dev/peps/pep-0257/
# Emacs-for-Python workflow
#     https://github.com/gabrielelanaro/emacs-for-python/wiki/workflow
# 26.3. unittest — Unit testing framework
#     https://docs.python.org/3/library/unittest.html
# PEP 0435: Adding an Enum type to the Python standard library
#     https://www.python.org/dev/peps/pep-0435/

# Standard library imports ---------------------------------------------#------#
# import this # Zen of Python easter egg
import unittest
from enum import Enum


# Related third party imports ------------------------------------------#------#

# Local and library imports --------------------------------------------#------#

def something():
    """Document what the something is here with the docstring.

    And then, if necessary expand. Keep to the 72 char line limit."""



# You can place the definitions of test cases and test suites in the
# same modules as the code they are to test (such as widget.py), but
# there are several advantages to placing the test code in a separate
# module, such as test_widget.py. -- 26.3.4. Organizing test code
    
class TestStringMethods(unittest.TestCase):

    def setUp(self):
        """Isolate common set up items here."""
        # I need to learn how i can make a self.string1="FOO" etc

    def tearDown(self):
        """Tidy up after the test method is run. """
    
    # The order in which the various tests will be run is determined
    # by sorting the test method names with respect to the built-in
    # ordering for strings. -- 26.3.4. Organizing test code
        
    def test_upper(self): # Test names begin with test_
        """One of the three examples from 26.3.1. Basic example"""        
        self.assertEqual('foo'.upper(), 'FOO')
        
    def test_isupper(self):
        self.assertTrue('FOO'.isupper())
        self.assertFalse('Foo'.isupper())

    def test_split(self):
        s = 'hello world'
        self.assertEqual(s.split(), ['hello', 'world'])
        # check that s.split fails when the separator is not a string
        with self.assertRaises(TypeError):
            s.split(2)

class ExpectedFailureTestCase(unittest.TestCase):

    @unittest.expectedFailure
    def test_fail(self):
        """From  26.3.6. Skipping tests and expected failures """
        self.assertEqual(1, 0, "broken")

            
# unittest.main() provides a command-line interface to the test script, -v
# increases the verbosity. -- 26.3.1. Basic example
if __name__ == '__main__':
    unittest.main()

                            
/* ticket
 * Author: 
 * Creation date: 08/04/21
 */
MACHINE    ticket
VARIABLES hour
CONSTANTS price1 /* valor da primeira hora*/, price2 /* valor extra adicionado a cada hora de 1h ate 3h*/, price3 /* valor extra adicionado a cada hora acima de 3h */

INVARIANT
    hour : NATURAL

PROPERTIES
    price1 : NATURAL & price2 : NATURAL & price3 : NATURAL & price1 = 7 & price2 = 1 & price3 = 3

INITIALISATION 
    hour := 0
    
OPERATIONS
        hh <-- inchour =
            hh, hour := hour+1, hour+1

END

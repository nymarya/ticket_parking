MACHINE
    ticket_machine

CONSTANTS
    MAX_TICKET, MAX_HOUR
    
PROPERTIES
    MAX_TICKET:NAT1 
    & MAX_HOUR:NAT1  
        
VARIABLES ticket, hour, value, aa
    
INVARIANT
    ticket : 0..MAX_TICKET --> {TRUE, FALSE} 
    & hour : 0..MAX_TICKET --> 0..MAX_HOUR
    & value : 0..MAX_TICKET --> 0..(10 + (MAX_HOUR -3 ) * 3)
    & aa : 0..MAX_HOUR
    
INITIALISATION 
   ticket, hour, value, aa := (0..MAX_TICKET)*{TRUE} , (0..MAX_TICKET)*{0}, (0..MAX_TICKET)*{0}, 0
    
OPERATIONS 
    inchour(tt) =
        PRE tt: 0..MAX_TICKET & hour(tt) < MAX_HOUR 
            & ticket(tt) = FALSE
        THEN hour(tt) := hour(tt)+1
        END;
            
    park(tt) = 
        PRE tt: 0..MAX_TICKET & ticket(tt) = TRUE
        THEN ticket(tt) := FALSE
        END;
        
    vv <-- calculate(tt) =
        PRE tt: 0..MAX_TICKET
        THEN IF hour(tt) <= 1 THEN vv :=  7
             ELSIF 1 < hour(tt) & hour(tt) <= 3 THEN vv := 7 + hour(tt)
             ELSE vv := 10 + (hour(tt) - 3) * 3
             END
        END;
        
    ss <-- status(tt) = 
        PRE tt:0..MAX_TICKET
        THEN ss := ticket(tt)
        END;
    
    hh <-- time(tt) = 
        PRE tt:0..MAX_TICKET
        THEN hh := hour(tt)
        END;

    // pagamento(valor)
    // valor tem que ser maior ou igual ao que pagar
    // saída é o troco
    // libera o cartão para saída
    tr <-- pay(vv, tt) = 
        PRE tt:0..MAX_TICKET & vv:NAT1 & ticket(tt) = FALSE
        THEN IF hour(tt) <= 1 THEN tr :=  vv -7 || ticket(tt) := TRUE || hour(tt) := 0 
             ELSIF 1 < hour(tt) & hour(tt) <= 3 THEN tr := vv - (7 + hour(tt)) || ticket(tt) := TRUE || hour(tt) := 0
             ELSE tr := vv - (10 + (hour(tt) - 3) * 3) || ticket(tt) := TRUE || hour(tt) := 0
             END
        END
END
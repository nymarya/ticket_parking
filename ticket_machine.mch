MACHINE
    ticket_machine

CONSTANTS
    MAX_TICKET, MAX_HOUR
SETS 
    STATUS = {available, parked}
PROPERTIES
    MAX_TICKET:NAT1 
    & MAX_HOUR:NAT1  
        
VARIABLES ticket, hour
    
INVARIANT
    ticket : 0..MAX_TICKET --> {available, parked} 
    & hour : 0..MAX_TICKET --> 0..MAX_HOUR
    & dom(ticket |> {available}) <: dom(hour |> {0}) 
    
INITIALISATION 
   ticket, hour := (0..MAX_TICKET)*{available} , (0..MAX_TICKET)*{0}
    
OPERATIONS 
    inchour(tt) =
        PRE tt: 0..MAX_TICKET & hour(tt) < MAX_HOUR
            & ticket(tt) = parked
        THEN hour(tt) := hour(tt)+1
        END;
            
    park(tt) = 
        PRE tt: 0..MAX_TICKET & ticket(tt) = available
        THEN ticket(tt) := parked
        END;
        
    vv <-- calculate(tt) = 
        PRE tt: 0..MAX_TICKET
        THEN IF hour(tt) <= 1 THEN vv :=  7
             ELSIF 1 < hour(tt) & hour(tt) <= 3 THEN vv := 7 + hour(tt)
             ELSE vv := 10 + (hour(tt) - 3) * 3
             END
        END;

    // pagamento(valor)
    // valor tem que ser maior ou igual ao que pagar
    // saída é o troco
    // libera o cartão para saída
    tr <-- pay(vv, tt) = 
        PRE tt:0..MAX_TICKET & vv:NAT1 & ticket(tt) = parked
        THEN IF hour(tt) <= 1 THEN tr :=  vv -7 || ticket(tt) := available || hour(tt) := 0
             ELSIF 1 < hour(tt) & hour(tt) <= 3 THEN tr := vv - (7 + hour(tt)) || ticket(tt) := available || hour(tt) := 0
             ELSE tr := vv - (10 + (hour(tt) - 3) * 3) || ticket(tt) := available || hour(tt) := 0
             END
        END
END

Device 18F4550
Xtal 4
'Config HS_osc,pwrte_OFF,wdt_off,boden_off,lvp_off,debug_off

Declare LCD_DTPin = PORTD.4
Declare LCD_RSPin = PORTD.2
Declare LCD_ENPin = PORTD.3
Declare LCD_Interface = 4
Declare LCD_Lines = 2
Declare LCD_Type = 0
Declare LCD_CommandUs = 2000
Declare LCD_DataUs = 50
 
 Declare Keypad_Port PORTB
Dim ii As Byte
Dim var1 As Byte
Dim var2 As Byte
Dim temp As Byte
Dim keydata As Byte
Dim keyres As Byte
Dim DEL As Word
Dim KL As Byte
Dim K As Byte
Dim PAS1 As Byte
Dim PAS2 As Byte
Dim  CHARR[12] As Byte

Dim counta As Byte
Dim  I As Byte
Dim keyres1 As Byte 
Dim t[3] As Byte 
Dim passward [6] As Byte 
Dim TOTAL As Word 
Dim RPM As Word
  Dim nn As Byte
  Dim nn1 As Byte

Dim HIGHT As Word  ' WITH ULTRASONIC SENSOR
Dim RANGE As Word ' 16 bit variable for Range
Symbol TRIGGER = PORTA.2 ' Define pin for Trigger pulse
Symbol ECHO = PORTA.1 ' Define pin for Echo pulse
 
 All_Digital TRUE
    TRISA=%00000011
    TRISB=0
    TRISC=%00000000
    TRISD=%00000000
    TRISE=%00000000
   
    'PORTD=%11111111
   
  
  PORTE=%00000000
  PORTC.7=1
  PORTC.6=1
  PORTC.5=1
  PORTC.4=1 
  PORTC.1=1
  PORTC.2=1 
  PORTD.0=1
  PORTD.1=1  
  PORTE.2=0
  PORTE.1=0
    GoSub ROBOT1_STOP
    Cls
    Print At 1,1,"RPM:",Dec RPM ," "
     
   
   Cls 
     Print At 1,1,"SEED PLANTATION "
     Print At 2,1,"   ROBOT        "

      DelayMS 2000
      
      
    

   'Cls
     ' GoSub ROBOT1_STOP
       'DelayMS 1000
        ' GoSub ROBOT1_DOWN
     ' DelayMS 1000
        'GoSub ROBOT1_JOWCLOSE
     ' DelayMS 1000
        'GoSub  ROBOT1_UP
     ' DelayMS 1000
         'GoSub ROBOT1_FORWRD
        ' DelayMS DEL
        ' GoSub ROBOT1_STOP
      'DelayMS 1000
         'GoSub ROBOT1_DOWN
     ' DelayMS 1000
        ' GoSub ROBOT1_JOWOPEN
      'DelayMS 1000
         'GoSub  ROBOT1_UP
     ' DelayMS 1000
         'GoSub  ROBOT1_REV
         'DelayMS DEL
         'GoSub ROBOT1_STOP



START:
       'GOSUB ROBOT2_STOP
      
       Cls 
       Print At 1,1,"ENTER VALUES "
       DelayMS 2000
       Print At 1,1,"ENTER NO OF ROWS  " 
       GoSub PASS_WARD 
        nn=TOTAL
         
         Cls
        Print At 1,1,"ENTER SEED DROPS"
        
         GoSub PASS_WARD
           DelayMS 2000
           nn1=TOTAL
             Cls
        Print At 1,1,"WORK START"  
             
             DelayMS 2000
        
       
       
       
      
      
      
     
   
   
    For ii=0 To nn
        GoSub ROBOT1_DOWN 
       
       For I= 0 To nn1
         Cls
  MMM:     
        PulsOut TRIGGER,15,High ' Produce a 15us high to low pulse
        RANGE = PulsIn ECHO,1 ' Measures the range in uS
        DelayMS 10 ' 10ms recharge period after ranging completes
        RANGE = RANGE / 5.57 ' Use 62 for cm or 149 for inches
        Print At 1,1,"COUNT", Dec I," "
       
        Print At 2,1,"OBST DIS = ", Dec RANGE," cm"
       
          If RANGE< 20 Then
          
          GoTo MMM
          Else
          EndIf
       
       GoSub ROBOT1_FORWRD
       '''''''''''''''''''''''''' FLAP''''''''''''''''''''
       DelayMS 100
       GoSub ROBOT1_JOWCLOSE
       DelayMS 200
       GoSub ROBOT1_JOWOPEN
       DelayMS 200
       Next I
        GoSub ROBOT1_UP
        '''''''''''''''''''''' TURN''''''''' 
         DelayMS 500
         
        If ii=0 Then
        
        GoSub ROBOT1_FORWRD 
        DelayMS 50 
        GoSub ROBOT1_RIGHT
        DelayMS 50
        GoSub ROBOT1_FORWRD 
        DelayMS 50
        GoSub ROBOT1_RIGHT
        Else
        EndIf
        
        If ii=1 Then
        
        GoSub ROBOT1_FORWRD 
        DelayMS 50
        GoSub ROBOT1_LEFT
        DelayMS 50
        GoSub ROBOT1_FORWRD
        DelayMS 50
        GoSub ROBOT1_LEFT
        Else
        EndIf
        
        If ii=2 Then
        
        GoSub ROBOT1_FORWRD 
        DelayMS 50
        GoSub ROBOT1_RIGHT
        DelayMS 50
        GoSub ROBOT1_FORWRD: 
        DelayMS 50
        GoSub ROBOT1_RIGHT 
        Else
        EndIf 
        
        If ii=3 Then
        GoSub ROBOT1_FORWRD 
        DelayMS 50
        GoSub ROBOT1_FORWRD 
        DelayMS 50
        GoSub ROBOT1_LEFT
        DelayMS 50
        GoSub ROBOT1_FORWRD
        DelayMS 50
        GoSub ROBOT1_LEFT
        Else
        EndIf
         
         
         DelayMS 500
         
       
     
     
     Next ii
     
    
    
    
    Cls 
     Print At 1,1,"SEED PLANTATION "
     Print At 2,1,"  WORK IS DONE  "
      DelayMS 1000
      
     '' GoSub ROBOT2_STOP
      
     GoTo START 
     
     
   ROBOT2_STOP:
   PORTC.1=1  ''''''''''FOR MOTION STOP
   PORTC.2=1
   PORTD.0=1
   PORTD.1=1 
   
   PORTC.7=1  ''''''''FOR JAW OPEN CLOSE STOP
    PORTC.6=1

   PORTE.1=1 ''''''''FOR JAW UP DOWN STOP
   PORTE.2=1
   Return

ROBOT1_FORWRD:
   PORTC.1=0
   PORTC.2=1
   PORTD.0=0
   PORTD.1=1
   DelayMS 1000
   PORTC.1=1
   PORTC.2=1
   PORTD.0=1
   PORTD.1=1 

Return

ROBOT1_LEFT:
   PORTC.1=0
   PORTC.2=1
   PORTD.0=1
   PORTD.1=1''''''''''''''''''''''''''''''''''''''''''''''
   DelayMS 3000
   PORTC.1=1
   PORTC.2=1
   PORTD.0=1
   PORTD.1=1 


Return

ROBOT1_RIGHT:
   PORTC.1=1
   PORTC.2=1
   PORTD.0=0
   PORTD.1=1
   DelayMS 3000
   PORTC.1=1
   PORTC.2=1
   PORTD.0=1
   PORTD.1=1 



Return



ROBOT1_REV:
   PORTC.1=1
   PORTC.2=0
   PORTD.0=1
   PORTD.1=0
   DelayMS 1000
   PORTC.1=1
   PORTC.2=1
   PORTD.0=1
   PORTD.1=1 
Return

ROBOT1_JOWCLOSE:
   PORTC.7=1
   PORTC.6=0
   DelayMS 400
    PORTC.7=1
    PORTC.6=1
Return

ROBOT1_JOWOPEN:
    PORTC.7=0
    PORTC.6=1
    DelayMS 400
    PORTC.7=1
    PORTC.6=1
Return

ROBOT1_DOWN:
   PORTE.1=1
   PORTE.2=0
   DelayMS 500
   PORTE.1=1
   PORTE.2=1
Return

ROBOT1_UP:
   PORTE.1=0
   PORTE.2=1
   DelayMS 500
   PORTE.1=1
   PORTE.2=1
Return

ROBOT1_STOP:
   PORTC.1=1
   PORTC.2=1
   PORTD.0=1
   PORTD.1=1 
Return

'//////////////////////////////////////////////////////



 '------------------------------------
find_key:
keydata = InKey
'keyres = LookUpL keydata,[10,0,11,15,7,8,9,15,4,5,6,15,1,2,3,12,16]
 keyres = LookUpL keydata,[1,4,7,10,1,4,7,10,2,5,8,0,3,6,9,11,16]

Return
'-------------------------------------
convertdata:
keyres1 = LookUpL keyres,["0","1","2","3","4","5","6","7","8","9","9","#","A","B","C","D",16]
Return 
'------------------------------------
convert1:
Clear STATUS.0
t[1]=t[1]<<4
temp = t[1]+t[2]
Return
'----------------------------------------------------------



 
 
PASS_WARD:
  

'Print Cls,"Enter value"
For var1 = 1 To 3 Step 1

m1:
          GoSub find_key
          If keyres > 14 Then GoTo m1
          If keyres = 14 Then 
                    Dec var1
                    GoTo pg1
                    EndIf
          
          Print At 2,var1,@keyres
          GoSub convertdata
         ' Print At 1,var1,keyres
          passward[var1] = keyres

pg1:          
          DelayMS 500
          Next
  
      TOTAL=  (passward[1]*100)+ (passward[2]*10)+ passward[3]


           
  
 
    DelayMS 3000
   
  
  Return

  SPEED:
   RPM= ADIn 0				    ' Place the conversion of channel 0
   
   Return 








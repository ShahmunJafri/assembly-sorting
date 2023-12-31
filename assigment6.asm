; DATE: June 8, 2023
comment *
Takes a number as an input.
Prints back to the console all the primes that are larger than 1 
but not larger than the number that has been entered
This procedure receives a number through one of the registers.
Checks if this number is prime. 
*
INCLUDE Irvine32.inc

.data
prompt byte "Please enter a number: ", 0
prompt2 byte "Primes found until the given number:", 0
space byte " ", 0

leaveCounter dword 0
.code

isPrime proc

    ;Wipes all of the registers to make dure they are empty
    xor edx, edx  
    xor ecx, ecx 
    xor ebx, ebx 

    ;Setting and saving our looping number with our inputed number
    mov ecx, eax
    
    ;Putting two into ebx to check if our number can be divide by 2
    mov ebx, 2

    ;Dividing and now checking the remainder values 
    ;to make sure the value is prime
    div ebx     

    mov eax, ecx

    ;Checking if the remainder of the divsion of ebx 
    ;if (edx == 0) return false, 
    ;then runs code to start checking that prime number

    cmp edx, 0        
    jz primeCheck

    ;Then calls to write the number
    call writeDec
    ret

primeCheck:
    
    ;Formula where ((number^2) - 1) / 24 gives prime number

    ;Our valued being squared and then minused by 1
    mul eax       
    sub eax, 1

    ;Clear our registery and then dividing by 24
    xor ebx, ebx
    mov ebx, 24    
    mov ecx, eax
    div ebx

    ;if (edx == 0) return false, this tell us that number is prime or not
    cmp edx, 0
    jz Prime
    ret

;Prime tell us whether the value tested is prime then we save the value
Prime:
    mov eax, ecx
    call writeDec
isPrime endp


main proc

    ;Message Prompt for the inputed number
    mov edx, offset prompt
    call writeString    
    call readDec
    call crlf

    ;Message prompt for the found prime numbers
    mov edx, offset prompt2
    call writeString
    call crlf 

primeLoop:
    ; save our eax value
    push eax     

    ; A counter that will keep track of loop
    mov eax, leaveCounter

    ; The call use the numbers through eax
    call isPrime 

    ; Get back our eax value
    pop eax          

    ;Places spaces between the numbers
    mov edx, offset space
    call writeString   

    ; compares leaveCounter and inputed number for loop
    cmp leaveCounter, eax

    ;If the leaveCounter is equal or more then the inputed number, then leave
    jae leaveAction        

    ;Updates the counter
    inc leaveCounter      

    ;Will retart the loop until the above conditions is met
    jmp primeLoop

;Just Exits the program
leaveAction:
    exit

main endp
end main

comment !
Please enter a number: 44

Primes found until the given number:
 1  3  5  7  9  11  13  15  17  19  21  23  25  27  29  31  33  35  37  39  41  43
C:\irvine\examples\Project32_VS2019\Debug\Project.exe (process 8912) exited with code 0.
To automatically close the console when debugging stops, enable Tools->Options->Debugging->Automatically close the console when debugging stops.
Press any key to close this window . . .
!
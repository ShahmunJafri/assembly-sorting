INCLUDE Irvine32.inc
;6/21/2023
;This assignment sorts an array using a variation of bubble sort
.data
    list1 DWORD 40 DUP(?)
    stop DWORD 0h
    length1 DWORD 0h
    indexOuter DWORD 0h

    prompt BYTE "After each element press enter: ", 0
    prompt2 BYTE "Initial array: ", 0
    prompt3 BYTE "Sorted array: ", 0
    space BYTE " ", 0

.code
main proc
    ; FILL YOUR CODE HERE
    ; YOU NEED TO CALL ENTER_ELEM, SORT_ARR AND PRINT_ARR PROCEDURES

    mov esi, OFFSET list1
    mov edx, OFFSET prompt
    call enter_elem

    mov edx, OFFSET prompt2
    mov esi, OFFSET list1
    call WriteString
    call print_arr

    call crlf

    mov edx, OFFSET prompt3
    call WriteString
    mov esi, OFFSET list1
    mov ecx, length1
    call sort_arr
    
    mov esi, OFFSET list1
    mov ecx, length1
    call print_arr
    
    exit
main endp

; ================================================
; void enter_elem()
;
; Input:
;   list of integers 
; Output:
;   array length and array
; Operation:
;   Fill the array and count the number of elements

enter_elem proc
    call writeString
    xor edx, edx
    ; while loop ends once a zero is inputted
    ; while (element entered != 0)
    while01:
        call ReadInt
        mov [esi], eax
        inc edx
        cmp eax, stop
        ; if (element entered == 0)
        je out1
        add esi, TYPE list1
        jmp while01
    out1:
        mov length1, edx
        ret
enter_elem endp

; ================================================
; void print_arr()
;
; Input:
;   array and array length
; Output:
;   printing out the array
; Operation:
;   Print out the array

print_arr proc
    mov esi, OFFSET list1
    ;i decided to do this method where ecx becomes zero and do 
    ; a reverse bubble sort
  
    
    loop01:
        mov eax, [esi]
        cmp eax, 0
        je out1
        call WriteDec
        mov edx, OFFSET space 
        call writeString
        add esi, TYPE list1
        jne loop01
        out1:
        ret
print_arr endp


; ================================================
; void sort_arr()
;
; Input:
;   array length and array
; Output:
;   sort the array, output nothing
; Operation:
;   Sort the array
   ; void bubbleSort(int arr[], int size) {
   ; for (int i = size - 1; i > 0; --i) {
      ;  for (int j = i; j > 0; --j) {
      ;      if (arr[j] > arr[j - 1]) {
     ;           // Swap arr[j] and arr[j-1]
     ;           int temp = arr[j];
     ;           arr[j] = arr[j - 1];
     ;           arr[j - 1] = temp;
     ;       }
     ;   }
  ;  }
;}
sort_arr proc
    mov ecx, length1   ; Initialize the loop counter with the length of the array
    add ecx, length1
    dec ecx            ; Decrement the counter by 1
    xor edx, edx
    
    outerloop:
        xor esi, esi
        mov indexOuter, ecx
        mov esi, OFFSET list1
        mov eax, TYPE list1
        mul ecx
        add esi, eax
        
        innerloop:
            mov eax, esi
            mov edx, esi  ; Compare with the previous element
            sub edx, TYPE list1
            call compare_and_swap
            sub esi, TYPE list1   ; Move to the previous element of the array
            loop innerloop
        
        mov ecx, indexOuter
        loop outerloop
    ret
sort_arr endp




; ===============================================
; void compare_and_swap()
;
; Input:
;   two array element pointers 
; Output:
;   nothing
; Operation:
;   Compare and call SWAP ONLY IF Y < X

compare_and_swap proc
    mov ebx, [eax]     ; Store the value of the first element in ebx
    mov edi, [edx]     ; Store the value of the second element in edi

    cmp edi, ebx       ; Compare the values of the elements
    ja skip_swap      ; Jump if second element is greater than or equal to the first
    call swap          ; Swap the elements if second element is smaller
    skip_swap:
    ret
  
compare_and_swap endp


; =================================================
; void swap()
;
; Input:
;   two array element pointers
; Output:
;   a somewhat more sorted array
; Operation:
;   Swap the two inputs
;int temp = a
;a = b
;b = temp
swap proc
    mov ebx, [eax]       ; Store the value of the first element in ebx
    mov edi, [edx]       ; Store the value of the second element in edi
    xchg [eax], edi      ; Swap the values of the elements using xchg
    xchg [edx], ebx
    ret
swap endp


end main

!
After each element press enter: 1
2
3
4
5
6
7
8
9
10
11
5
2
5
6
4
5
0
Initial array: 1 2 3 4 5 6 7 8 9 10 11 5 2 5 6 4 5
Sorted array: 11 10 9 8 7 6 6 5 5 5 5 4 4 3 2 2 1
C:\Users\Tech\source\repos\asssignment77\Debug\asssignment77.exe (process 12424) exited with code 0.
To automatically close the console when debugging stops, enable Tools->Options->Debugging->Automatically close the console when debugging stops.
Press any key to close this window . . .
!
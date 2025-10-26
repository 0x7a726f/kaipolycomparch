#===============================================================
#1A
#Με int* array = $a0, int size = $a1 και $v0 = min
.data
array: .word 6, 1, 2, 8, 4      #  array
size:  .word 5                  #  size

.text
.globl main                     # entry point

main:
    la   $a0, array             # $a0 = &array[0]
    lw   $a1, size              # $a1 = size (5)
    jal  min                    # call min(array, size)
    
    move $a0, $v0               # Για εκτύπωση
    li   $v0, 1                 # syscall: print_int
    syscall

    li   $v0, 10                # syscall: exit
    syscall

min:
    lw      $t0, 0($a0)         # $t0 = array[0] Εδώ αποθηκεύω το minimum, το αρχικοποιώ στο πρώτο στοιχείο του array
    move    $v0, $t0            # min = array[0]
    addi    $t1, $zero, 1       # $t1 = 1 (loop μεταβλητή i=1)
loop:
    bge     $t1, $a1, done      # if i >= size, exit loop
    sll     $t2, $t1, 2         # $t2 = i * 4 (byte offset επειδή πιάνουν 4 θέσεις)
    add     $t3, $a0, $t2       # $t3 δείχνει στην αρχή του array[i]
    lw      $t4, 0($t3)         # $t4 = array[i] Για να αποθηκεύσω τη τιμή στο t4
    blt     $t4, $v0, update    # if array[i] < minimum, update
    addi    $t1, $t1, 1         # i++
    j       loop
update:
    move    $v0, $t4            # minimum = array[i]
    addi    $t1, $t1, 1         # i++
    j       loop
done:
    jr      $ra

#===============================================================
#1B

addi $s1, $0, 0        # i = 0
addi $t2, $0, 1000     # Ο t2 = 1000

loop:
slt  $t0, $s1, $t2     # if (i < 1000) then t0 = 1 else t0 = 0
beq  $t0, $0, done     # if (i >= 1000) go to done

sll  $t0, $s1, 2       # t0 = i * 4 κάνει wd offset
add  $t0, $t0, $s0     # t0 = διεύθυνση arr[i]
lw   $t1, 0($t0)       # t1 = arr[i]
sll  $t1, $t1, 3       # t1 = arr[i] * 8
sw   $t1, 0($t0)       # arr[i] = t1 βάζω τη τιμή *8 πίσω 

addi $s1, $s1, 1       # i++
j loop                 # επανάληψη πίσω στο loop

done:

#Σε C   
#   int i = 0;
#   while (i < 1000) {
#       arr[i] = arr[i] * 8;
#       i++;
#}
#===============================================================

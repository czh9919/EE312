# Lab-report

## Introduction

This project required us to design a 16-bit ALU, which is based on basic logical operators and the variables.
From this project we will learn how to use the operators and variable of the Verilog HDL programming language and how to simulate it.
Such as add operator and how to deal with the overflow.


We use three 16-bit arrays to regard the two 16-bit binary input number and the output number.
The operators are use 4-bit binary number to regard.
We use case structure to realize the operators.

## Design
For design an ALU module, we should know how the ALU work.
This project is a simple ALU system. 
Input 16-bit arrays and 4-bit operators, then inside the system the system will distinguish the operators and transport the data into related case. 
Then use different operators to calculate the data, and get the results.






## Implementation
### AND
For the AND operator. 
AND operator is the logical operator-> '&'.
we input A, B and the operator AND, then get the output C= A & B. Besides, the AND operator does not exist the problem that overflow, so we only need to set cout=0.  


### NAND
NAND operator is based on AND operator, which is inverse of the AND operator. 
Like the process of "AND" operator, we only need to add a '~' before the process that "AND" operator, so we get C=~(A&B).
It does not exist overflow.


### XOR 
XOR operator is exclusive OR, which is the operator that if input are the same, then the output will be 0. 
And if the input are different, then the output will be 1.
Then we get C= A^B.
It does not exist overflow.


### identity
As for identity, that output is equal to its input A.
Then we get C= A. 
It does not exist overflow.


### Logical shift 
logical shift operator is about let the element in Array A shift right side for 1 position, and use 0 to supplement the empty space due to displacement.
we will get C=A >> 1.
It does not exist overflow.


### rotate right 
Rotate right operator is that let the last element of the arrar A to be the first element, and then other element shift right for one position. 
We will get C={A[0],A[15:1]}.
It does not exist overflow.


### Arithmetic left shift 
The Arithmetic left shift operator is to rotate the element in the array A lefthand 1 position, and use 0 to supplement the empty space due to displacement.  
Then C=A <<< 1.
It does not exist overflow.


## Evaluation

## Discussion

## Conclusion


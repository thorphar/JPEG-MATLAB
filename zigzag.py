for i in range(1, 9):
    length = i
    for x in range(1,i+1):
        if(i%2==0):
            print (str(x) + "," + str(length))
        else:
            print(str(length) + "," + str(x))
        length = length - 1

counterA = 2
counterB = 8
for x in range (1, 8):
    counterC = counterA
    counterD = counterB
    for i in range (1,abs(x-8)+1):
        if(x == 1):
            print (str(counterD) + "," + str(counterC))
        elif(x % 2 == 0):
            print (str(counterC) + "," + str(counterD))
        else:
            print (str(counterD) + "," + str(counterC))
        counterC += 1
        counterD -= 1
    counterA += 1

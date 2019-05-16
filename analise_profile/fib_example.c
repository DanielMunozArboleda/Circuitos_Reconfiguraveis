#include <stdio.h>

long add(long x, long y){
     int foo = (x>y)?x:y;
     long x1 = x/foo;
     long x2 = x%foo;
     long y1 = y/foo;
     long y2 = y%foo;
     return x1*foo+x2+y1*foo+y2;
}

long fib(int i){
     if (i<2) return 1;
     return add(fib(i-1),fib(i-2));
}

int main(){
    long l = fib(36);
    printf("fib(36)=%ld\n",l);
    return 0; 
}

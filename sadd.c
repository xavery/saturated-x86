#include <limits.h>
#include <assert.h>

int sadd(int a, int b);

int main(void)
{
    assert(sadd(2,5) == (2+5));
    assert(sadd(-2,-5) == (-2 + -5));
    assert(sadd(0,0) == (0 + 0));
    assert(sadd(-2,5) == (-2 + 5));
    assert(sadd(5,-2) == (5 + -2));
    assert(sadd(INT_MAX, 0) == (INT_MAX + 0));
    assert(sadd(INT_MAX, -5) == (INT_MAX + -5));
    assert(sadd(INT_MAX, 5) == INT_MAX);
    assert(sadd(INT_MIN, 0) == (INT_MIN + 0));
    assert(sadd(INT_MIN, -5) == INT_MIN);
    assert(sadd(INT_MIN, 5) == (INT_MIN + 5));
    return 0;
}

#include <limits.h>
#include <assert.h>
#include <stddef.h>

int sadd(int a, int b);
int sadd_pushf_cmov(int a, int b);

typedef int (*sadd_impl_fn)(int, int);

static const sadd_impl_fn sadd_impls[] = { sadd, sadd_pushf_cmov,
    sadd_setcc_cmov };

#define SIZE(x) (sizeof(x)/sizeof(*x))

static void test(sadd_impl_fn impl)
{
    assert(impl(2,5) == (2+5));
    assert(impl(-2,-5) == (-2 + -5));
    assert(impl(0,0) == (0 + 0));
    assert(impl(-2,5) == (-2 + 5));
    assert(impl(5,-2) == (5 + -2));
    assert(impl(INT_MAX, 0) == (INT_MAX + 0));
    assert(impl(INT_MAX, -5) == (INT_MAX + -5));
    assert(impl(INT_MAX, 5) == INT_MAX);
    assert(impl(INT_MIN, 0) == (INT_MIN + 0));
    assert(impl(INT_MIN, -5) == INT_MIN);
    assert(impl(INT_MIN, 5) == (INT_MIN + 5));
}

int main(void)
{
    size_t i;
    for(i = 0 ; i < SIZE(sadd_impls) ; ++i)
    {
        test(sadd_impls[i]);
    }
    return 0;
}

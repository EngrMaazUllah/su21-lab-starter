#include <stddef.h>
#include <stdio.h>
#include "ll_cycle.h"

int ll_has_cycle(node *head) {
    /* TODO: Implement ll_has_cycle */
    node *fastPointer = head;
    node *slowPointer = head;
    while (fastPointer != NULL && fastPointer->next != NULL && fastPointer->next->next != NULL)
    {
        fastPointer = fastPointer->next->next;
        slowPointer = slowPointer->next;
        if (fastPointer == slowPointer)
            return 1;
        if (fastPointer == NULL && fastPointer->next->next == NULL)
            return 1;
    }
    return 0;
}


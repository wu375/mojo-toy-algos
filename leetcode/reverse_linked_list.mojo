# Unsuccesful attempt

# @register_passable("trivial")
# struct ListNode:
#     var val: Int
#     var next: Pointer[ListNode]
    
#     @always_inline
#     fn __init__(val: Int) -> Self:
#         return ListNode {val: val, next: Pointer[ListNode].get_null()}

# let node1.next = Pointer[ListNode](node2)
# let node2.next = Pointer[ListNode](node3)
# let node3.next = Pointer[ListNode](node4)


# A hacky way to implement reverse linked list behavior
# Use @register_passable("trivial") because Pointer[].load() and .store() somehow don't work with in-memory struct
@register_passable("trivial")
struct ListNode:
    # var val: Int
    var next: Int # pointer to the index of the next node
    var index: Int # index of the node in the list
    
    @always_inline
    fn __init__(index: Int) -> Self:
        return ListNode {next: -1, index: index}

let MAX_NODES = 100

# Testcase 1
# Input: 1->4->6->8->9->NULL
# Output: 9->8->6->4->1->NULL
let nodeVals = Pointer[Int].alloc(MAX_NODES)
let nodes = Pointer[ListNode].alloc(MAX_NODES)

node1 = ListNode(0)
nodeVals.store(0, 1)
node2 = ListNode(1)
nodeVals.store(1, 4)
node1.next = 1
nodes.store(0, node1)
node3 = ListNode(2)
nodeVals.store(2, 6)
node2.next = 2
nodes.store(1, node2)
node4 = ListNode(3)
nodeVals.store(3, 8)
node3.next = 3
nodes.store(2, node3)
node5 = ListNode(4)
nodeVals.store(4, 9)
node4.next = 4
nodes.store(3, node4)
node5.next = -1
nodes.store(4, node5)



def reverseList(head: ListNode, nodes: Pointer[ListNode], nodeVals: Pointer[Int]) -> ListNode:
    prev_index = -1
    curr_index = head.index
    while curr_index != -1:
        # nxt = curr.next
        nxt_index = nodes.load(curr_index).next

        # curr.next = prev
        curr_node = nodes.load(curr_index)
        curr_node.next = prev_index
        nodes.store(curr_index, curr_node)

        # prev = curr
        prev_index = curr_index

        # curr = nxt
        curr_index = nxt_index
    
    return nodes.load(prev_index)
        


print('Linked List before reversing:')
curr = node1
print_no_newline(nodeVals.load(curr.index))
print_no_newline(' -> ')
while curr.next != -1:
    curr = nodes.load(curr.next)
    print_no_newline(nodeVals.load(curr.index))
    print_no_newline(' -> ')
print('NULL')

head_new = reverseList(node1, nodes, nodeVals)

print('Linked List after reversing:')
curr = head_new
print_no_newline(nodeVals.load(curr.index))
print_no_newline(' -> ')
while curr.next != -1:
    curr = nodes.load(curr.next)
    print_no_newline(nodeVals.load(curr.index))
    print_no_newline(' -> ')
print('NULL')
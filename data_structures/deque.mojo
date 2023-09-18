struct Deque[T: AnyType]:
    var data: Pointer[T]
    var capacity: Int
    var size: Int
    var front: Int # index of the first element
    var rear: Int # index of the last element
    var init_capacity: Int # TODO: probably shouldn't put here

    fn __init__(inout self):
        self.init_capacity = 10
        self.data = Pointer[T].alloc(self.init_capacity)
        self.capacity = self.init_capacity
        self.size = 0
        self.front = 0
        self.rear = 0

    fn resize(inout self, new_capacity: Int):
        let new_data = Pointer[T].alloc(new_capacity)
        for i in range(self.size):
            # new_data[i] = self.data[(self.front + i) % self.capacity]
            let data_i = self.data.load((self.front + i) % self.capacity)
            new_data.store(i, data_i)
        self.data.free()
        self.data = new_data
        self.capacity = new_capacity
        self.front = 0
        self.rear = self.size

    fn push_front(inout self, value: T):
        if self.size == self.capacity:
            self.resize(self.capacity * 2)
        self.front = (self.front - 1 + self.capacity) % self.capacity # make sure it's positive
        # self.data[self.front] = value
        self.data.store(self.front, value)
        self.size += 1

    fn push_back(inout self, value: T):
        if self.size == self.capacity:
            self.resize(self.capacity * 2)
        # self.data[self.rear] = value
        self.data.store(self.rear, value)
        self.rear = (self.rear + 1) % self.capacity
        self.size += 1

    fn pop_front(inout self) raises -> T:
        # assert self.size > 0
        if self.size == 0:
            raise Error('Deque is empty')
        # value = self.data[self.front]
        let value = self.data.load(self.front)
        self.front = (self.front + 1) % self.capacity
        self.size -= 1
        if self.capacity > self.init_capacity and self.size * 4 <= self.capacity: # 4 is like a heuristic
            self.resize(self.capacity // 2)
        return value

    fn pop_back(inout self) raises -> T:
        # assert self.size > 0
        if self.size == 0:
            raise Error('Deque is empty')
        self.rear = (self.rear - 1 + self.capacity) % self.capacity
        # value = self.data[self.rear]
        let value = self.data.load(self.rear)
        self.size -= 1
        if self.capacity > self.init_capacity and self.size * 4 <= self.capacity:
            self.resize(self.capacity // 2)
        return value

    fn __getitem__(self, i: Int) -> T:
        return self.data.load(i)

    fn __del__(owned self):
        self.data.free()

    # doesn't work with wildcard types
    # fn dump(self):
    #     print_no_newline("[")
    #     for i in range(self.size):
    #         print_no_newline(self.data.load((self.front + i) % self.capacity))
    #         if i < self.size - 1:
    #             print_no_newline(", ")
    #     print("]")



# queue = Deque[Int]()
# for i in range(100):
#     queue.push_back(i)

# for i in range(80):
#     queue.pop_front()

# for i in range(15):
#     queue.pop_back()

# for i in range(85):
#     queue.push_front(i)

# print_no_newline("[")
# for i in range(queue.size):
#     print_no_newline(queue.data.load((queue.front + i) % queue.capacity))
#     if i < queue.size - 1:
#         print_no_newline(", ")
# print("]")

# print_no_newline('Size: ')
# print(queue.size)

# print_no_newline('Capacity: ')
# print(queue.capacity)
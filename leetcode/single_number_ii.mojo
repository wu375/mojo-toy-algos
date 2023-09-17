def singleNumber(nums: DynamicVector[Int]) -> Int:
    ones = 0
    twos = 0
    threes = 0
    for i in range(len(nums)):
        n = nums[i]
        twos = twos | (ones & n)
        ones = ones ^ n
        threes = twos & ones

        ones = ones & ~threes
        twos = twos & ~threes
    return ones


# Testcase 1
# [2,2,3,2]
# expected: 3
# nums = DynamicVector[Int]()
# nums.push_back(2)
# nums.push_back(2)
# nums.push_back(3)
# nums.push_back(2)
# res = singleNumber(nums)
# print(res)


# Testcase 2
# [0,1,0,1,0,1,99]
# expected: 99
# nums = DynamicVector[Int]()
# nums.push_back(0)
# nums.push_back(1)
# nums.push_back(0)
# nums.push_back(1)
# nums.push_back(0)
# nums.push_back(1)
# nums.push_back(99)
# res = singleNumber(nums)
# print(res)


# Testcase 3
# [-2,-2,1,1,-3,1,-3,-3,-4,-2]
# expected: -4
nums = DynamicVector[Int]()
nums.push_back(-2)
nums.push_back(-2)
nums.push_back(1)
nums.push_back(1)
nums.push_back(-3)
nums.push_back(1)
nums.push_back(-3)
nums.push_back(-3)
nums.push_back(-4)
nums.push_back(-2)
res = singleNumber(nums)
print(res)

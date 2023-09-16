from python import Python
from python.object import PythonObject
from algorithm.sort import sort
from memory.unsafe import DTypePointer

def threeSum(nums: DynamicVector[Int]) -> DTypePointer[DType.int8]:
    sort(nums)
    res = Python.dict()
    for i in range(len(nums)):
        target = -nums[i]
        l = i + 1
        r = len(nums) - 1
        while l < len(nums) and l < r:
            if nums[l] + nums[r] > target:
                r -= 1
            elif nums[l] + nums[r] < target:
                l += 1
            else:
                res[(nums[i], nums[l], nums[r])] = True
                r -= 1
                l += 1
                while l < r and nums[l] == nums[l-1]:
                    l += 1
                while l < r and nums[r] == nums[r+1]:
                    r -= 1
                    
    N = res.__len__().__index__()
    
    res_ptr = DTypePointer[DType.int8].alloc(N * 3)
    i = 0
    for tpl in res:
        j = 0
        for e in tpl:
            e_int = e.__index__()

            res_ptr.simd_store[1](i * 3 + j, e_int)
            j += 1

        i += 1
    return res_ptr


tc_d = DynamicVector[Int]()
tc_d.push_back(-1)
tc_d.push_back(0)
tc_d.push_back(1)
tc_d.push_back(2)
tc_d.push_back(-1)
tc_d.push_back(-4)

res = threeSum(tc_d)

# printing
for i in range(2):
    print_no_newline("[ ")
    for j in range(3):
        print_no_newline(res.simd_load[1](i*3+j))
        if j != (3 - 1):
            print_no_newline(", ")
    print_no_newline("]")
    put_new_line()

res.free()
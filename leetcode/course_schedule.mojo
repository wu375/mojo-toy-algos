from python import Python
from python.object import PythonObject
from python import Dictionary

fn helper(i: Int, edges: Dictionary, inout visited: Dictionary, inout visiting: Dictionary) raises -> Bool:
    if not Python.is_type(visiting.get(i), Python.none()): # if i not in visiting
        return False
    
    if Python.is_type(visited.get(i), Python.none()): # if i not in visited
        if not Python.is_type(edges.get(i), Python.none()): # if i in edges
            visiting[i] = True
            for n in edges[i]:
                let n_int = n.__index__()
                if not helper(n_int, edges, visited, visiting):
                    return False
            visiting.pop(i) # warning: Expression [25]:21:25: 'PythonObject' value is unused
        visited[i] = True
        print_no_newline(i)
        print_no_newline(', ')
    return True

fn canFinish(numCourses: Int, prerequisites: DTypePointer[DType.int8], prerequisitesSize: Int) raises -> Bool:
    let edges = Python.dict()

    for i in range(prerequisitesSize):
        let p_1 = prerequisites.simd_load[1](i * 2 + 1).to_int()
        if Python.is_type(edges.get(p_1), Python.none()): # if not p_1 in edges:
            edges[p_1] = []
        let p_0 = PythonObject(prerequisites.simd_load[1](i * 2))
        edges[p_1].append(p_0) # warning: Expression [25]:35:26: 'PythonObject' value is unused
        
    # for e in edges:
    #     print(e)
    #     print(edges[e])
    # for i in range(numCourses):
    #     if not Python.is_type(edges.get(i), Python.none()):
    #         print('in')
    #         print(edges[i])
    #     else:
    #         print('out')

    var visited = Python.dict()
    var visiting = Python.dict()

    print_no_newline('Topological sort: ')
    for i in range(numCourses):
        if not helper(i, edges, visited, visiting):
            return False

    return True


# Testcase 1
# [[1,2],[3,4],[4,5],[1,5],[3,5],[1,0]]
# prerequisites = DTypePointer[DType.int8].alloc(6 * 2)
# prerequisites.simd_store[1](0, 1)
# prerequisites.simd_store[1](1, 2)

# prerequisites.simd_store[1](2, 3)
# prerequisites.simd_store[1](3, 4)

# prerequisites.simd_store[1](4, 4)
# prerequisites.simd_store[1](5, 5)

# prerequisites.simd_store[1](6, 1)
# prerequisites.simd_store[1](7, 5)

# prerequisites.simd_store[1](8, 3)
# prerequisites.simd_store[1](9, 5)

# prerequisites.simd_store[1](10, 1)
# prerequisites.simd_store[1](11, 0)

# res = canFinish(6, prerequisites, 6)
# print(res)


# Testcase 2
# [[2, 5], [0, 5], [0, 4], [1, 4], [3, 2], [1, 3]]
prerequisites = DTypePointer[DType.int8].alloc(6 * 2)
prerequisites.simd_store[1](0, 2)
prerequisites.simd_store[1](1, 5)

prerequisites.simd_store[1](2, 0)
prerequisites.simd_store[1](3, 5)

prerequisites.simd_store[1](4, 0)
prerequisites.simd_store[1](5, 4)

prerequisites.simd_store[1](6, 1)
prerequisites.simd_store[1](7, 4)

prerequisites.simd_store[1](8, 3)
prerequisites.simd_store[1](9, 2)

prerequisites.simd_store[1](10, 1)
prerequisites.simd_store[1](11, 3)

res = canFinish(6, prerequisites, 6)
print(res)

import numpy as np

def clamp(x, bit):
    x = max(x, -2**(bit-1))
    x = min(x, 2**(bit-1)-1)
    return x


def wino(A, B):
    # A: matrix(6x6), B: matrix(3x3)
    assert A.shape == (6, 6)
    assert B.shape == (3, 3)
    _A = np.zeros([6, 6], dtype=np.int64)
    _Ai = np.zeros([6, 6], dtype=np.int64)
    for j in range(0, 6):
        _A[0, j] = A[0, j]-A[4, j]
        _A[1, j] = A[1, j]+A[2, j]+A[3, j]+A[4, j]
        _A[2, j] = -A[1, j]+A[2, j]-A[3, j]+A[4, j]
        _A[3, j] = -A[2, j]+A[4, j]
        _A[4, j] = -A[2, j]+A[4, j]
        _A[5, j] = -A[1, j]+A[5, j]
        _Ai[3, j] = -A[1, j]+A[3, j]
        _Ai[4, j] = A[1, j]-A[3, j]
    print("_A<<<<<<<<<<<<")
    for i in range(0, 6):
        for j in range(0, 4):
            print(_A[i, j])
    print("_A<<<<<<<<<<<<")
    __A = np.zeros([6, 6], dtype=np.int64)
    __Ai = np.zeros([6, 6], dtype=np.int64)
    for i in range(0, 6):
        __A[i, 0] = _A[i, 0]-_A[i, 4]
        __A[i, 1] = _A[i, 1]+_A[i, 2]+_A[i, 3]+_A[i, 4]
        __A[i, 2] = -_A[i, 1]+_A[i, 2]-_A[i, 3]+_A[i, 4]
        __A[i, 3] = -_A[i, 2]+_A[i, 4]-_Ai[i, 3]+_Ai[i, 1]
        __A[i, 4] = -_A[i, 2]+_A[i, 4]+_Ai[i, 3]-_Ai[i, 1]
        __A[i, 5] = -_A[i, 1]+_A[i, 5]
        __Ai[i, 0] = _Ai[i, 0]-_Ai[i, 4]
        __Ai[i, 1] = _Ai[i, 1]+_Ai[i, 2]+_Ai[i, 3]+_Ai[i, 4]
        __Ai[i, 2] = -_Ai[i, 1]+_Ai[i, 2]-_Ai[i, 3]+_Ai[i, 4]
        __Ai[i, 3] = -_Ai[i, 2]+_Ai[i, 4]-_A[i, 1]+_A[i, 3]
        __Ai[i, 4] = -_Ai[i, 2]+_Ai[i, 4]+_A[i, 1]-_A[i, 3]
        __Ai[i, 5] = -_Ai[i, 1]+_Ai[i, 5]
    print("__A<<<<<<<<<<<<")
    for i in range(0, 6):
        for j in range(0, 4):
            print(__A[i, j])
    print("__A<<<<<<<<<<<<")
    _B = np.zeros([6, 3], dtype=np.int64)
    _Bi = np.zeros([6, 3], dtype=np.int64)
    for j in range(0, 3):
        _B[0, j] = B[0, j]
        _B[1, j] = B[0, j]+B[1, j]+B[2, j]
        _B[2, j] = B[0, j]-B[1, j]+B[2, j]
        _B[3, j] = B[0, j]-B[2, j]
        _B[4, j] = B[0, j]-B[2, j]
        _B[5, j] = B[2, j]
        _Bi[3, j] = B[1, j]
        _Bi[4, j] = -B[1, j]

    __B = np.zeros([6, 6], dtype=np.int64)
    __Bi = np.zeros([6, 6], dtype=np.int64)

    for i in range(0, 6):
        __B[i, 0] = _B[i, 0]
        __B[i, 1] = _B[i, 0]+_B[i, 1]+_B[i, 2]
        __B[i, 2] = _B[i, 0]-_B[i, 1]+_B[i, 2]
        __B[i, 3] = _B[i, 0]-_B[i, 2]-_Bi[i, 1]
        __B[i, 4] = _B[i, 0]-_B[i, 2]+_Bi[i, 1]
        __B[i, 5] = _B[i, 2]
        __Bi[i, 0] = _Bi[i, 0]
        __Bi[i, 1] = _Bi[i, 0]+_Bi[i, 1]+_Bi[i, 2]
        __Bi[i, 2] = _Bi[i, 0]-_Bi[i, 1]+_Bi[i, 2]
        __Bi[i, 3] = _Bi[i, 0]-_Bi[i, 2]+_B[i, 1]
        __Bi[i, 4] = _Bi[i, 0]-_Bi[i, 2]-_B[i, 1]
        __Bi[i, 5] = _Bi[i, 2]
    # for i in range(0, 6):
        # for j in range(0, 6):
        # assert __B[i, j]+(2**18) <= 2**19
    W = np.zeros([6, 6], dtype=np.int64)
    Wi = np.zeros([6, 6], dtype=np.int64)

    for i in range(6):
        for j in range(6):
            __B[i, j] = clamp(__B[i, j], 18)
            __Bi[i, j] = clamp(__Bi[i, j], 18)
    """
    for i in range(0, 6):
        for j in range(0, 6):
            W[i, j] = __A[i, j]*__B[i, j]-__Ai[i, j]*__Bi[i, j]
            Wi[i, j] = __Ai[i, j]*__B[i, j]+__A[i, j]*__Bi[i, j]
    """
    for i in range(0, 6):
        for j in range(0, 6):
            if(i == 3 or i == 4 or j == 3 or j == 4):
                f1 = (__A[i, j]+__Ai[i, j])*(__B[i, j]+__Bi[i, j])
                f2 = __A[i, j]*__B[i, j]
                f3 = __Ai[i, j]*__Bi[i, j]
                W[i, j] = f2-f3
                Wi[i, j] = f1-f2-f3
            else:
                W[i, j] = __A[i, j]*__B[i, j]
    _W = np.zeros([4, 6], dtype=np.int64)
    _Wi = np.zeros([4, 6], dtype=np.int64)
    print("W<<<<<<<<<<<<")
    for i in range(0, 6):
        for j in range(0, 6):
            print(W[i, j])
    print("W<<<<<<<<<<<<")
    for j in range(0, 6):
        _W[0, j] = W[0, j]+(W[1, j]+W[2, j]+W[3, j]+W[4, j])//4
        _W[1, j] = (W[1, j]-W[2, j]-Wi[3, j]+Wi[4, j])//4
        _W[2, j] = (W[1, j]+W[2, j]-W[3, j]-W[4, j])//4
        _W[3, j] = (W[1, j]-W[2, j]+Wi[3, j]-Wi[4, j])//4+W[5, j]
		
        _Wi[0, j] = Wi[0, j]+(Wi[1, j]+Wi[2, j]+Wi[3, j]+Wi[4, j])//4
        _Wi[1, j] = (Wi[1, j]-Wi[2, j]+W[3, j]-W[4, j])//4
        _Wi[2, j] = (Wi[1, j]+Wi[2, j]-Wi[3, j]-Wi[4, j])//4
        _Wi[3, j] = (Wi[1, j]-Wi[2, j]-W[3, j]+W[4, j])//4+Wi[5, j]
    print("_W<<<<<<<<<<<<")
    for i in range(0, 4):
        for j in range(0, 6):
            print(_W[i, j])
    print("_W<<<<<<<<<<<<")
    __W = np.zeros([4, 4], dtype=np.int64)
    for i in range(0, 4):
        __W[i, 0] = _W[i, 0]+(_W[i, 1]+_W[i, 2]+_W[i, 3]+_W[i, 4])//4
        __W[i, 1] = (_W[i, 1]-_W[i, 2]-_Wi[i, 3]+_Wi[i, 4])//4
        __W[i, 2] = (_W[i, 1]+_W[i, 2]-_W[i, 3]-_W[i, 4])//4
        __W[i, 3] = (_W[i, 1]-_W[i, 2]+_Wi[i, 3]-_Wi[i, 4])//4+_W[i, 5]
    
    for i in range(0, 4):
        for j in range(0, 4):
            print(__W[i, j])
    
    return __W


A = np.zeros([6, 6], dtype=np.int64)
B = np.zeros([3, 3], dtype=np.int64)
for i in range(0, 6): A[0, i] = i+1919
for i in range(1, 6):
    for j in range(1, 6):
        A[i, j] = (i-1)*8+(j-1)+1145
    A[i, 0] = (i-1)+191
for i in range(9): B[i//3][i%3] = i+1
wino(A, B)
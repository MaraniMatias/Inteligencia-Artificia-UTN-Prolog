class Programa(object):

    def __init__(self):
        self.recorridos = {
            'ciudad1': ["ciudad2", "ciudad4"],
            'ciudad2': ["ciudad3", "ciudad5", "ciudad1"],
            'ciudad3': [],
            'ciudad4': ["ciudad5", "ciudad6"],
            'ciudad5': ["ciudad6"],
            'ciudad6': []
        }

    def conexion(self, A, B, A_original= None):
        # print "Buscar conexion {0} con {1}".format(A, B)
        exite_conexion = A == B or A == A_original or False
        for destino in self.recorridos[A]:
            if (destino == B):
                exite_conexion = True
            if (not exite_conexion):
                exite_conexion = self.conexion(destino, B, A_original or A)

        return exite_conexion

if __name__ == "__main__":

    programa = Programa()
    conexion = programa.conexion

    print '1', conexion("ciudad1", "ciudad1") and "Exite conexion"
    print '2', conexion("ciudad1", "ciudad2") and "Exite conexion"
    print '3', conexion("ciudad1", "ciudad3") and "Exite conexion"
    print '4', conexion("ciudad1", "ciudad4") and "Exite conexion"
    print '5', conexion("ciudad1", "ciudad5") and "Exite conexion"
    print '6', conexion("ciudad1", "ciudad6") and "Exite conexion"
    print '7', conexion("ciudad2", "ciudad1") and "Exite conexion"
    print '8', conexion("ciudad2", "ciudad4") and "Exite conexion"
    print '9', conexion("ciudad2", "ciudad5") and "Exite conexion"
    print '10', conexion("ciudad2", "ciudad6") and "Exite conexion"
    print '11', conexion("ciudad3", "ciudad2") or "No exite conexion"
    print '12', conexion("ciudad3", "ciudad6") or "No exite conexion"
    print '13', conexion("ciudad4", "ciudad1") or "No exite conexion"
    print '14', conexion("ciudad5", "ciudad2") or "No exite conexion"
    print '15', conexion("ciudad6", "ciudad1") or "No exite conexion"

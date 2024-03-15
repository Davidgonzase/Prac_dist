import org.junit.Before;
import org.junit.Test;

import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

import static org.junit.Assert.assertEquals;

public class Tests {
    private Interfaz interfaz;


    @Before
    public void setup() throws RemoteException, NotBoundException {
    Registry registro = LocateRegistry.getRegistry("localhost",1200);
    interfaz=(Interfaz) registro.lookup("Calculadora");


    }

    @Test
    public void testSumar() throws RemoteException {
        assertEquals(8.0f, interfaz.sumar(5, 3, 0), 0.01);
    }

    @Test
    public void testRestar() throws RemoteException {
        assertEquals(5.0f, interfaz.restar(8, 3), 0.01);
    }

    @Test
    public void testMultiplicar() throws RemoteException {
        assertEquals(20.0f, interfaz.multiplicar(4, 5), 0.01);
    }

    @Test
    public void testDividir() throws RemoteException {
        assertEquals(5.0f, interfaz.dividir(10, 2), 0.01);
    }

    @Test
    public void testDividirCero() throws RemoteException {
        assertEquals(-1.0f, interfaz.dividir(10, 0), 0.01);
    }

    @Test
    public void testRaiz() throws RemoteException {
        assertEquals(5.0f, interfaz.raiz(25), 0.01);
    }

    @Test
    public void testRaizNegativa() throws RemoteException {
        assertEquals(-1.0f, interfaz.raiz(-25), 0.01);
    }
}
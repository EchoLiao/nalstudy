package com.sun.corba.se.spi.activation;


/**
* com/sun/corba/se/spi/activation/InitialNameServiceOperations.java .
* Generated by the IDL-to-Java compiler (portable), version "3.2"
* from ../../../../src/share/classes/com/sun/corba/se/spi/activation/activation.idl
* Monday, March 9, 2009 1:55:37 AM GMT-08:00
*/

public interface InitialNameServiceOperations 
{

  // bind initial name
  void bind (String name, org.omg.CORBA.Object obj, boolean isPersistant) throws com.sun.corba.se.spi.activation.InitialNameServicePackage.NameAlreadyBound;
} // interface InitialNameServiceOperations

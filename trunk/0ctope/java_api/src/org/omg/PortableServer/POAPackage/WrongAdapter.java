package org.omg.PortableServer.POAPackage;


/**
* org/omg/PortableServer/POAPackage/WrongAdapter.java .
* Generated by the IDL-to-Java compiler (portable), version "3.2"
* from ../../../../src/share/classes/org/omg/PortableServer/poa.idl
* Monday, March 9, 2009 1:40:41 AM GMT-08:00
*/

public final class WrongAdapter extends org.omg.CORBA.UserException
{

  public WrongAdapter ()
  {
    super(WrongAdapterHelper.id());
  } // ctor


  public WrongAdapter (String $reason)
  {
    super(WrongAdapterHelper.id() + "  " + $reason);
  } // ctor

} // class WrongAdapter

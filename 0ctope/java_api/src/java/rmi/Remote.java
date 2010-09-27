/*
 * @(#)Remote.java	1.18 06/04/21
 *
 * Copyright 2006 Sun Microsystems, Inc. All rights reserved.
 * SUN PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */

package java.rmi;

/** 
 * The <code>Remote</code> interface serves to identify interfaces whose
 * methods may be invoked from a non-local virtual machine.  Any object that
 * is a remote object must directly or indirectly implement this interface.
 * Only those methods specified in a "remote interface", an interface that
 * extends <code>java.rmi.Remote</code> are available remotely.
 *
 * <p>Implementation classes can implement any number of remote interfaces and
 * can extend other remote implementation classes.  RMI provides some
 * convenience classes that remote object implementations can extend which
 * facilitate remote object creation.  These classes are
 * <code>java.rmi.server.UnicastRemoteObject</code> and
 * <code>java.rmi.activation.Activatable</code>.
 *
 * <p>For complete details on RMI, see the <a
 href=../../../platform/rmi/spec/rmiTOC.html>RMI Specification</a> which describes the RMI API and system.
 *
 * @version 1.18, 04/21/06
 * @since   JDK1.1
 * @author  Ann Wollrath
 * @see	    java.rmi.server.UnicastRemoteObject
 * @see     java.rmi.activation.Activatable
 */
public interface Remote {}
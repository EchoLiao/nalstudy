/*
 * @(#)file      JDMHostTrap.java
 * @(#)author    Sun Microsystems, Inc.
 * @(#)version   4.8
 * @(#)date      09/03/09
 *
 * Copyright 2006 Sun Microsystems, Inc. All rights reserved.
 * SUN PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 *
 */


/* Generated By:JJTree: Do not edit this line. JDMHostTrap.java */

package com.sun.jmx.snmp.IPAcl;

/** 
 * @version     4.8     11/17/05 
 * @author      Sun Microsystems, Inc. 
 */ 
class JDMHostTrap extends SimpleNode {
  protected String name= "";

  JDMHostTrap(int id) {
    super(id);
  }

  JDMHostTrap(Parser p, int id) {
    super(p, id);
  }

  public static Node jjtCreate(int id) {
      return new JDMHostTrap(id);
  }

  public static Node jjtCreate(Parser p, int id) {
      return new JDMHostTrap(p, id);
  }
}

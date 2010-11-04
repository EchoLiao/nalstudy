/*
 * @(#)MenuListener.java	1.13 05/11/17
 *
 * Copyright 2006 Sun Microsystems, Inc. All rights reserved.
 * SUN PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */
package javax.swing.event;


import java.util.EventListener;
 
 
/**
 * Defines a listener for menu events.
 *
 * @version 1.13 11/17/05
 * @author Georges Saab
 */
public interface MenuListener extends EventListener {
    /**
     * Invoked when a menu is selected.
     *
     * @param e  a MenuEvent object
     */
    void menuSelected(MenuEvent e);
    /**
     * Invoked when the menu is deselected.
     *
     * @param e  a MenuEvent object
     */
    void menuDeselected(MenuEvent e);
    /**
     * Invoked when the menu is canceled.
     *
     * @param e  a MenuEvent object
     */
    void menuCanceled(MenuEvent e);
}

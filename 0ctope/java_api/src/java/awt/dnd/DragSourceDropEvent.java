/*
 * @(#)DragSourceDropEvent.java	1.20 05/11/17
 *
 * Copyright 2006 Sun Microsystems, Inc. All rights reserved.
 * SUN PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */

package java.awt.dnd;

/**
 * The <code>DragSourceDropEvent</code> is delivered 
 * from the <code>DragSourceContextPeer</code>,
 * via the <code>DragSourceContext</code>, to the <code>dragDropEnd</code>
 * method of <code>DragSourceListener</code>s registered with that
 * <code>DragSourceContext</code> and with its associated
 * <code>DragSource</code>. 
 * It contains sufficient information for the 
 * originator of the operation
 * to provide appropriate feedback to the end user 
 * when the operation completes.
 * <P>
 * @version 	1.20, 11/17/05
 * <P>
 * @since 1.2
 */

public class DragSourceDropEvent extends DragSourceEvent {

    private static final long serialVersionUID = -5571321229470821891L;

    /**
     * Construct a <code>DragSourceDropEvent</code> for a drop, 
     * given the 
     * <code>DragSourceContext</code>, the drop action, 
     * and a <code>boolean</code> indicating if the drop was successful.
     * The coordinates for this <code>DragSourceDropEvent</code> 
     * are not specified, so <code>getLocation</code> will return
     * <code>null</code> for this event.
     * <p> 
     * The argument <code>action</code> should be one of <code>DnDConstants</code>
     * that represents a single action.
     * This constructor does not throw any exception for invalid <code>action</code>.
     * 
     * @param dsc the <code>DragSourceContext</code> 
     * associated with this <code>DragSourceDropEvent</code>
     * @param action the drop action
     * @param success a boolean indicating if the drop was successful
     *
     * @throws <code>IllegalArgumentException</code> if <code>dsc</code> is <code>null</code>.
     *
     * @see DragSourceEvent#getLocation
     */

    public DragSourceDropEvent(DragSourceContext dsc, int action, boolean success) {
	super(dsc);

	dropSuccess = success;
	dropAction  = action;
    }

    /**
     * Construct a <code>DragSourceDropEvent</code> for a drop, given the
     * <code>DragSourceContext</code>, the drop action, a <code>boolean</code>
     * indicating if the drop was successful, and coordinates.
     * <p> 
     * The argument <code>action</code> should be one of <code>DnDConstants</code>
     * that represents a single action.
     * This constructor does not throw any exception for invalid <code>action</code>.
     * 
     * @param dsc the <code>DragSourceContext</code> 
     * associated with this <code>DragSourceDropEvent</code>
     * @param action the drop action
     * @param success a boolean indicating if the drop was successful
     * @param x   the horizontal coordinate for the cursor location
     * @param y   the vertical coordinate for the cursor location
     *
     * @throws <code>IllegalArgumentException</code> if <code>dsc</code> is <code>null</code>.
     *
     * @since 1.4
     */
    public DragSourceDropEvent(DragSourceContext dsc, int action, 
                               boolean success, int x, int y) {
        super(dsc, x, y);

        dropSuccess = success;
        dropAction  = action;
    }

    /**
     * Construct a <code>DragSourceDropEvent</code>
     * for a drag that does not result in a drop.
     * The coordinates for this <code>DragSourceDropEvent</code> 
     * are not specified, so <code>getLocation</code> will return
     * <code>null</code> for this event.
     *
     * @param dsc the <code>DragSourceContext</code>
     *
     * @throws <code>IllegalArgumentException</code> if <code>dsc</code> is <code>null</code>.
     *
     * @see DragSourceEvent#getLocation
     */

    public DragSourceDropEvent(DragSourceContext dsc) {
	super(dsc);

	dropSuccess = false;
    }

    /**
     * This method returns a <code>boolean</code> indicating 
     * if the drop was successful.
     * 
     * @return <code>true</code> if the drop target accepted the drop and
     *         successfully performed a drop action;
     *         <code>false</code> if the drop target rejected the drop or 
     *         if the drop target accepted the drop, but failed to perform 
     *         a drop action.
     */

    public boolean getDropSuccess() { return dropSuccess; }

    /**
     * This method returns an <code>int</code> representing 
     * the action performed by the target on the subject of the drop.
     *
     * @return the action performed by the target on the subject of the drop
     *         if the drop target accepted the drop and the target drop action
     *         is supported by the drag source; otherwise,
     *         <code>DnDConstants.ACTION_NONE</code>. 
     */

    public int getDropAction() { return dropAction; }

    /*
     * fields
     */

    /**
     * <code>true</code> if the drop was successful.
     *
     * @serial
     */
    private boolean dropSuccess;

    /**
     * The drop action.
     *
     * @serial
     */
    private int	    dropAction   = DnDConstants.ACTION_NONE;
}
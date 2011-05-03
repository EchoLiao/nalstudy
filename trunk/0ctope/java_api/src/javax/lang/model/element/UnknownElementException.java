/*
 * @(#)UnknownElementException.java	1.3 06/07/31
 *
 * Copyright 2006 Sun Microsystems, Inc. All rights reserved.
 * SUN PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */

package javax.lang.model.element;

/**
 * Indicates that an unknown kind of element was encountered.  This
 * can occur if the language evolves and new kinds of elements are
 * added to the {@code Element} hierarchy.  May be thrown by an
 * {@linkplain ElementVisitor element visitor} to indicate that the
 * visitor was created for a prior version of the language.
 *
 * @author Joseph D. Darcy
 * @author Scott Seligman
 * @author Peter von der Ah&eacute;
 * @version 1.3 06/07/31
 * @see ElementVisitor#visitUnknown
 * @since 1.6
 */
public class UnknownElementException extends RuntimeException {

    private static final long serialVersionUID = 269L;

    private transient Element element;
    private transient Object parameter;

    /**
     * Creates a new {@code UnknownElementException}.  The {@code p}
     * parameter may be used to pass in an additional argument with
     * information about the context in which the unknown element was
     * encountered; for example, the visit methods of {@link
     * ElementVisitor} may pass in their additional parameter.
     *
     * @param e the unknown element, may be {@code null}
     * @param p an additional parameter, may be {@code null}
     */
    public UnknownElementException(Element e, Object p) {
	super("Unknown element: " + e);
	element = e;
	this.parameter = p;
    }

    /**
     * Returns the unknown element.
     * The value may be unavailable if this exception has been
     * serialized and then read back in.
     *
     * @return the unknown element, or {@code null} if unavailable
     */
    public Element getUnknownElement() {
	return element;
    }

    /**
     * Returns the additional argument.
     *
     * @return the additional argument
     */
    public Object getArgument() {
	return parameter;
    }
}
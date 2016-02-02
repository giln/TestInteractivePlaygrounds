# TestInteractivePlaygrounds

Example project to test designing UI by code in playgrounds.


Add source files from project to ModuleInteractive target to access them from playgrounds.

Also note the:

`
@testable import ModuleInteractive
`

Without the `@testable import` everything has to be declared public.

The playgrounds use Manual and Auto Layout (ios9 NSLayoutAnchor) for testing purposes.


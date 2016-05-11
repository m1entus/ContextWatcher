# ContextWatcher

This example project show how to observer changes on single NSManagedObject.

```swift
let context = NSManagedObjectContext.defaultContext
let observer = CoreDataContextObserver(context: context)

observer.observeObject(journal, completionBlock: { object, state in
    print(“CHANGED: \(object.changedValuesForCurrentEvent())\n”)
    print(“state: \(state)”)
})
```

```swift
public struct CoreDataContextObserverState : OptionSetType {
    static public let Inserted: ContextWatcher.CoreDataContextObserverState
    static public let Updated: ContextWatcher.CoreDataContextObserverState
    static public let Deleted: ContextWatcher.CoreDataContextObserverState
    static public let Refreshed: ContextWatcher.CoreDataContextObserverState
    static public let All: CoreDataContextObserverState
}
public typealias CoreDataContextObserverCompletionBlock = (NSManagedObject, CoreDataContextObserverState) -> ()

public class CoreDataContextObserver {

    public var enabled: Bool
    private(set) var context: NSManagedObjectContext

    public init(context: NSManagedObjectContext)

    public func observeObject(object: NSManagedObject, state: CoreDataContextObserverState = default, completionBlock: CoreDataContextObserverCompletionBlock)
    public func unobserveObject(object: NSManagedObject, forState state: CoreDataContextObserverState = default)
    public func unobserveAllObjects()
}
```
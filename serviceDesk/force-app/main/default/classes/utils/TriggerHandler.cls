public abstract with sharing class TriggerHandler {

    public System.TriggerOperation operation {get; set;}
    
    public TriggerHandler(System.TriggerOperation operation) {
        this.operation = operation;
    }

    public void execute() {
        if (this.operation == System.TriggerOperation.BEFORE_INSERT) {
            beforeInsert();
        }
        else if (this.operation == System.TriggerOperation.AFTER_INSERT) {
            afterInsert();
        }
        else if (this.operation == System.TriggerOperation.BEFORE_UPDATE) {
            beforeUpdate();
        }
        else if (this.operation == System.TriggerOperation.AFTER_UPDATE) {
            afterUpdate();
        }
        else if (this.operation == System.TriggerOperation.BEFORE_DELETE) {
            beforeDelete();
        }
        else if (this.operation == System.TriggerOperation.AFTER_DELETE) {
            afterDelete();
        }
    }

    public abstract void beforeInsert();

    public abstract void afterInsert();

    public abstract void beforeUpdate();

    public abstract void afterUpdate();

    public abstract void beforeDelete();

    public abstract void afterDelete();

}
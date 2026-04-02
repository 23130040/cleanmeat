function openAddPaymentModal() {
    document.getElementById('addPaymentModal').classList.add('show');
}
function closeAddPaymentModal() {
    document.getElementById('addPaymentModal').classList.remove('show');
}
function openEditPaymentModal(id, name) {
    document.getElementById('edit-payment-id').value = id;
    document.getElementById('edit-payment-name').value = name;
    document.getElementById('editPaymentModal').classList.add('show');
}
function closeEditPaymentModal() {
    document.getElementById('editPaymentModal').classList.remove('show');
}